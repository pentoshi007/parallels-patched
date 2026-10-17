// libprlqtfix.dylib — neutralize Qt 5.15's setuid refusal inside prl_vm_app only,
// in memory. The on-disk QtCore.framework stays pristine: its Parallels Developer
// ID signature must remain valid for library-validation-enforcing product binaries
// (prl_net_start, ParallelsVirtualizationSDK) that load the same framework.
//
// The VM app runs with euid=0 (via the setuid wrapper) so libvmnet's client passes
// the vmnet daemon's "root or entitled by provisioning-locked entitlement" check.
// Qt aborts in QCoreApplicationPrivate's ctor when geteuid() != getuid(); we clear
// the cached "setuid allowed" flag (skips the check) and NOP the fatal branch.
#include <mach-o/dyld.h>
#include <mach-o/loader.h>
#include <libkern/OSCacheControl.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stdio.h>
#include <stdint.h>
#include <stdarg.h>
#include <string.h>

#define QTC_MATCH "QtCore.framework/Versions/5/QtCore"
#define FLAG_OFF  0x514228u   /* cached "setuid allowed" byte tested by tbnz */
#define GUARD_OFF 0x1d658c    /* b.ne -> qFatal("running setuid") path */
#define BNE_LE    0x54000341u
#define NOP_LE    0x1f2003d5u

static long pg_size(void) {
    static long pg;
    if (!pg) pg = sysconf(_SC_PAGESIZE);
    return pg;
}

static void logmsg(const char *fmt, ...) {
    FILE *f = fopen("/tmp/prl_qtfix.log", "a");
    if (!f) return;
    va_list ap;
    va_start(ap, fmt);
    vfprintf(f, fmt, ap);
    va_end(ap);
    fputc('\n', f);
    fclose(f);
}

static int make_writable(void *addr) {
    uintptr_t pg = (uintptr_t)addr & ~((uintptr_t)pg_size() - 1);
    return mprotect((void *)pg, pg_size(), PROT_READ | PROT_WRITE);
}

static void patch_image(const struct mach_header *mh, intptr_t slide) {
    if (mh->magic != MH_MAGIC_64) return;
    const char *name = NULL;
    uint32_t n = _dyld_image_count();
    for (uint32_t i = 0; i < n; i++) {
        if (_dyld_get_image_header(i) == mh) { name = _dyld_get_image_name(i); break; }
    }
    if (!name || !strstr(name, QTC_MATCH)) return;

    /* mh is the runtime address of the Mach-O header; __TEXT vmaddr is 0 in this
       slice, so runtime address of any vmaddr == (uint8_t*)mh + vmaddr. The dyld
       "slide" is only needed for vmaddr -> runtime math, and mh already includes it. */
    uint8_t *base = (uint8_t *)mh;
    volatile uint8_t *flag = base + FLAG_OFF;
    volatile uint32_t *guard = (volatile uint32_t *)(base + GUARD_OFF);
    uint32_t before = *guard;
    int flag_before = *flag;

    int flag_rc = make_writable((void *)flag);
    if (flag_rc == 0) {
        *flag = 1;
        flag_rc = *flag == 1 ? 0 : -2;
    }
    int nop_rc = -3;
    if (before == NOP_LE) {
        nop_rc = 1;                          /* already patched */
    } else if (before == BNE_LE) {
        uintptr_t pg = (uintptr_t)guard & ~((uintptr_t)pg_size() - 1);
        if (mprotect((void *)pg, pg_size(), PROT_READ | PROT_WRITE) == 0) {
            *guard = NOP_LE;
            sys_icache_invalidate((void *)guard, sizeof(uint32_t));
            mprotect((void *)pg, pg_size(), PROT_READ | PROT_EXEC);
            nop_rc = *guard == NOP_LE ? 0 : -4;
        } else {
            nop_rc = -5;
        }
    }
    logmsg("pid=%d euid=%d ruid=%d img=%s slide=%#lx base=%p guard=%p "
           "guard_before=%#010x flag_before=%d flag_rc=%d nop_rc=%d guard_after=%#010x",
           getpid(), geteuid(), getuid(), name, (unsigned long)slide,
           (void *)base, (void *)guard, before, flag_before, flag_rc, nop_rc, *guard);
}

__attribute__((constructor))
static void prl_qtfix_init(void) {
    logmsg("pid=%d euid=%d ruid=%d libprlqtfix init, images=%u",
           getpid(), geteuid(), getuid(), _dyld_image_count());
    _dyld_register_func_for_add_image(patch_image);
}

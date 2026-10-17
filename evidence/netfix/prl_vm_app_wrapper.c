// Setuid-root launcher installed as .../Parallels VM.app/Contents/MacOS/prl_vm_app.
// The real VM binary lives beside it as prl_vm_app.bin (non-setuid: a setuid main
// binary may not use @rpath expansions, and the app's Qt dependencies are @rpath).
// The wrapper is setuid root, so the exec'd .bin inherits euid=0 with ruid=501 --
// exactly what libvmnet's client needs to pass the vmnet daemon's root check.
#include <mach-o/dyld.h>
#include <unistd.h>
#include <stdio.h>
#include <libgen.h>
#include <limits.h>

int main(int argc, char **argv) {
    char exe[PATH_MAX];
    uint32_t sz = sizeof(exe);
    if (_NSGetExecutablePath(exe, &sz) != 0) return 126;
    char bin[PATH_MAX];
    if (snprintf(bin, sizeof(bin), "%s/prl_vm_app.bin", dirname(exe)) >= (int)sizeof(bin))
        return 126;
    execv(bin, argv);
    perror("prl_vm_app wrapper: execv");
    return 127;
}

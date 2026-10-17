#!/usr/bin/env python3
"""Build the transfer zip (preserves symlinks; .dmg stored uncompressed)."""
import os
import stat
import sys
import zipfile


def main():
    src = sys.argv[1].rstrip('/')
    out = sys.argv[2]
    base = os.path.dirname(src)
    n_files = n_links = n_dirs = 0

    def add_dir(z, arc):
        nonlocal n_dirs
        zi = zipfile.ZipInfo(arc + '/')
        zi.external_attr = (0o40755 << 16) | 0x10
        zi.create_system = 3
        zi.compress_type = zipfile.ZIP_STORED
        z.writestr(zi, b'')
        n_dirs += 1

    with zipfile.ZipFile(out, 'w', allowZip64=True, compresslevel=6) as z:
        add_dir(z, os.path.basename(src))
        for root, dirs, files in os.walk(src):
            dirs.sort()
            files.sort()
            rel_root = os.path.relpath(root, base)
            if rel_root != '.':
                add_dir(z, rel_root)
            for name in files:
                p = os.path.join(root, name)
                rel = os.path.relpath(p, base)
                if os.path.islink(p):
                    zi = zipfile.ZipInfo(rel)
                    zi.external_attr = (0o120777 << 16)
                    zi.create_system = 3
                    zi.compress_type = zipfile.ZIP_STORED
                    z.writestr(zi, os.readlink(p))
                    n_links += 1
                    continue
                st = os.lstat(p)
                zi = zipfile.ZipInfo.from_file(p, rel)
                zi.external_attr = (stat.S_IMODE(st.st_mode) << 16)
                zi.create_system = 3
                zi.compress_type = (zipfile.ZIP_STORED
                                    if name.lower().endswith('.dmg')
                                    else zipfile.ZIP_DEFLATED)
                with open(p, 'rb') as f, z.open(zi, 'w') as dst:
                    while True:
                        chunk = f.read(1 << 20)
                        if not chunk:
                            break
                        dst.write(chunk)
                n_files += 1
    print('zip written: %s (%d files, %d dirs, %d symlinks)' % (out, n_files, n_dirs, n_links))


main()

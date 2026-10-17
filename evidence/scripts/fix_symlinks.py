import os, sys

def main():
    errfile, root = sys.argv[1], sys.argv[2]
    made = exists = 0
    with open(errfile, 'r', errors='replace') as fh:
        for line in fh:
            if 'Dangerous link path was ignored' not in line:
                continue
            parts = line.rstrip('\n').split(' : ')
            if len(parts) < 3:
                print('UNPARSED:', line.strip()); continue
            path, target = parts[-2], parts[-1]
            full = os.path.join(root, path)
            if os.path.islink(full):
                exists += 1; continue
            if os.path.lexists(full):
                # 7z materializes unsafe symlinks as empty placeholder files
                if os.path.isfile(full) and os.path.getsize(full) == 0:
                    os.remove(full)
                else:
                    print('KEEP (not empty file):', full); exists += 1; continue
            os.makedirs(os.path.dirname(full), exist_ok=True)
            os.symlink(target, full)
            made += 1
    print(f'symlinks created={made} already_present={exists}')

main()

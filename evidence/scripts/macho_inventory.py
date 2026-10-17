import os, sys, struct, json

CPU = {12:'arm', 16777228:'arm64', 7:'x86', 16777223:'x86_64'}
KW = [b'licens', b'activation', b'genuine', b'trial', b'subscription', b'parallels.com',
      b'expired', b'licenses.json', b'receipt', b'hardware id', b'account', b'renew',
      b'not genuine', b'purchase', b'upgrade', b'token']

def archs_of(head):
    m = head[:4]
    if m in (b'\xca\xfe\xba\xbe', b'\xbf\xba\xfe\xca'):
        n = struct.unpack('>I', head[4:8])[0]; out = []; off = 8
        for _ in range(min(n, 8)):
            cpu = struct.unpack('>i', head[off:off+4])[0]; out.append(CPU.get(cpu, hex(cpu))); off += 20
        return out
    if m == b'\xca\xfe\xba\xbf':
        n = struct.unpack('>I', head[4:8])[0]; out = []; off = 8
        for _ in range(min(n, 8)):
            cpu = struct.unpack('>i', head[off:off+4])[0]; out.append(CPU.get(cpu, hex(cpu))); off += 32
        return out
    if m in (b'\xcf\xfa\xed\xfe', b'\xce\xfa\xed\xfe', b'\xfe\xed\xfa\xcf', b'\xfe\xed\xfa\xce'):
        little = m[0] in (0xcf, 0xce)
        cpu = struct.unpack('<i' if little else '>i', head[4:8])[0]
        return [CPU.get(cpu, hex(cpu))]
    return None

def main():
    root, outdir = sys.argv[1], sys.argv[2]
    machos = []
    for dp, dn, fn in os.walk(root):
        for f in fn:
            p = os.path.join(dp, f)
            try:
                with open(p, 'rb') as fh: head = fh.read(512)
            except OSError: continue
            a = archs_of(head)
            if not a: continue
            try:
                with open(p, 'rb') as fh: blob = fh.read().lower()
            except OSError: blob = b''
            hits = {}
            for kw in KW:
                c = blob.count(kw)
                if c: hits[kw.decode()] = c
            machos.append({'path': os.path.relpath(p, root), 'archs': a,
                           'size': os.path.getsize(p), 'hits': hits})
    with open(os.path.join(outdir, 'macho-inventory.json'), 'w') as fh:
        json.dump(machos, fh, indent=1)
    def score(m):
        h = m['hits']
        return (h.get('genuine',0)*10 + h.get('activation',0)*4 + h.get('parallels.com',0)*4
                + h.get('licenses.json',0)*8 + h.get('subscription',0)*4 + h.get('trial',0)*2
                + h.get('expired',0)*2 + h.get('licens',0) + h.get('receipt',0)*3)
    machos.sort(key=score, reverse=True)
    lines = []
    lines.append(f'{len(machos)} Mach-O files total')
    uni = sum(1 for m in machos if len(m['archs']) > 1)
    lines.append(f'universal={uni} thin={len(machos)-uni}')
    lines.append('--- top licensing-relevant ---')
    for m in machos[:40]:
        if score(m) <= 0: break
        h = m['hits']
        inter = {k: v for k, v in h.items() if k in ('genuine','activation','parallels.com',
                 'licenses.json','subscription','trial','expired','licens','receipt','purchase','renew','not genuine')}
        lines.append(f"{m['size']:>10} {','.join(m['archs']):>12}  {m['path']}")
        lines.append(f"{'':>26}  {inter}")
    text = '\n'.join(lines)
    with open(os.path.join(outdir, 'licensing-triage.txt'), 'w') as fh:
        fh.write(text)
    print(text)

main()

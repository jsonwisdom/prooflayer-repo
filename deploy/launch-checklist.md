# ZTWS Launch Checklist — Countdown Mode

> **⚠️ SAFETY: PRIVATE_KEY**
>
> The `PRIVATE_KEY` referenced in this checklist must:
>
> - Never be committed to this repository
> - Never be pasted into any file tracked by git
> - Never be logged, echoed, or written to disk
> - Exist only in the shell environment during manual deployment
>
> If a private key appears in any commit, rotate it immediately.

Use this file as the single run order. Do not skip ahead. If a step is not complete, stop there.

## 0. Preconditions
- [ ] `PRIVATE_KEY` is loaded in shell
- [ ] `JUDICIAL_SAFE` is known
- [ ] Base mainnet ETH is available for gas
- [ ] `deploy-commands.sh` has been reviewed locally

**Stop if not complete.**

---

## 1. Deploy Registry
Run the deploy command.

Expected outputs to capture:
- `REGISTRY=0x...`
- `TX_HASH=0x...`

Paste-back fields:
```text
REGISTRY=
TX_HASH=
```

**Stop if `REGISTRY` is missing.**

---

## 2. Get Deploy Block
Run receipt lookup.

Expected output to capture:
- `DEPLOY_BLOCK=...`

Paste-back fields:
```text
DEPLOY_BLOCK=
```

**Stop if `DEPLOY_BLOCK` is missing.**

---

## 3. Verify Contract
- [ ] Contract bytecode exists on Base mainnet
- [ ] Optional BaseScan verification completed

Suggested checks:
```bash
cast code $REGISTRY --rpc-url https://mainnet.base.org
```

**Stop if bytecode is empty.**

---

## 4. Generate Manifest
Create `manifest.v1.json` with live values.

Expected outputs to capture:
- `MANIFEST_CID=...`

Paste-back fields:
```text
MANIFEST_CID=
```

**Stop if `MANIFEST_CID` is missing.**

---

## 5. ENS Pointer Lock
Only after `REGISTRY` and `MANIFEST_CID` both exist.

Keys to set on `jaywisdom.base.eth`:
- `ztws.registry.v1`
- `ztws.manifest.v1`
- `ztws.version`

**Stop if either pointer write fails.**

---

## 6. Watchdog Start
Run both modes separately.

Genesis mode:
```bash
python3 observer/watchdog.py \
  --registry 0x082836b2A8E2a77Cca7DDd9F9fC8eE99F884F58D \
  --start-block 44202259
```

ZTWS mode:
```bash
python3 observer/watchdog.py \
  --registry $REGISTRY \
  --start-block $DEPLOY_BLOCK
```

**Stop if watchdog does not start cleanly.**

---

## 7. Final Ready State
Paste this block only when all required fields are real:

```text
REGISTRY=0x...
TX_HASH=0x...
DEPLOY_BLOCK=...
MANIFEST_CID=...
```

At that point:
- Genesis anchor = sealed
- ZTWS registry = live
- ENS pointers = locked
- Watchdog = running

System state: operational.

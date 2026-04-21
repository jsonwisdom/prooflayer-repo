# ENS Pointers — ZTWS Registry Anchor

## Identity Anchor
- **ENS Name:** `jaywisdom.base.eth`
- **Controller Wallet:** `0xa380552a27b0a5a2874ea7aa52cac09f542002e8`
- **Chain:** Base Mainnet (chainId: 8453)
- **Resolver:** Public Resolver (auto-resolved by ENS registry)

## Text Records to Set

| Key | Value (placeholder) |
|-----|---------------------|
| `ztws.registry.v1` | `0x[TBD_REGISTRY_ADDRESS]` |
| `ztws.manifest.v1` | `ipfs://[TBD_MANIFEST_CID]` |
| `ztws.version` | `1.0.0` |
| `ztws.auditor` | `0xa380552a27b0a5a2874ea7aa52cac09f542002e8` |

## Cast Commands (run after REGISTRY is deployed)

```bash
# Set registry address
cast send jaywisdom.base.eth \
  "setText(bytes32,string,string)" \
  $(cast namehash "jaywisdom.base.eth") \
  "ztws.registry.v1" \
  "0x[TBD_REGISTRY_ADDRESS]" \
  --rpc-url https://mainnet.base.org

# Set manifest CID
cast send jaywisdom.base.eth \
  "setText(bytes32,string,string)" \
  $(cast namehash "jaywisdom.base.eth") \
  "ztws.manifest.v1" \
  "ipfs://[TBD_MANIFEST_CID]" \
  --rpc-url https://mainnet.base.org

# Set version
cast send jaywisdom.base.eth \
  "setText(bytes32,string,string)" \
  $(cast namehash "jaywisdom.base.eth") \
  "ztws.version" \
  "1.0.0" \
  --rpc-url https://mainnet.base.org
```

L1 Mirror (jaywisdom.eth)

Same keys, same values. Set on Ethereum mainnet after Base records are confirmed.

```bash
# Same commands, different RPC
--rpc-url https://eth-mainnet.g.alchemy.com/v2/$ALCHEMY_KEY
```

Verification

```bash
# Read back records
cast call jaywisdom.base.eth \
  "getText(bytes32,string)" \
  $(cast namehash "jaywisdom.base.eth") \
  "ztws.registry.v1" \
  --rpc-url https://mainnet.base.org
```

Status

· Registry deployed on Base
· ENS text records set on .base.eth
· Manifest uploaded to IPFS
· L1 mirror set on .eth
· Watchdog verifies records

## Genesis Anchor (Verified Mainnet)

> **Important:** This is a Genesis proof contract, not the ZTWS mainnet registry.  
> Do not set `ztws.registry.v1` to this address unless explicitly intended.

| Field | Value |
|-------|-------|
| **Genesis Contract** | `0x082836b2A8E2a77Cca7DDd9F9fC8eE99F884F58D` |
| **Genesis Block** | `44202259` |
| **Anchor ENS** | `jaywisdom.base.eth` |
| **Network** | Base Mainnet (chainId: 8453) |

### Verification Commands

```bash
export GENESIS_REGISTRY=0x082836b2A8E2a77Cca7DDd9F9fC8eE99F884F58D
export GENESIS_BLOCK=44202259
export BASE_RPC=https://mainnet.base.org

# Verify contract bytecode exists
cast code $GENESIS_REGISTRY --rpc-url $BASE_RPC

# View genesis logs
cast logs --address $GENESIS_REGISTRY \
  --from-block $GENESIS_BLOCK \
  --to-block $((GENESIS_BLOCK + 50)) \
  --rpc-url $BASE_RPC
```

Watchdog Initialization (Genesis Mode)

```bash
python3 observer/watchdog.py \
  --registry 0x082836b2A8E2a77Cca7DDd9F9fC8eE99F884F58D \
  --start-block 44202259
```

Relationship to ZTWS Registry

· Genesis Contract: Proof-of-existence anchor, immutable, serves as timestamped foundation
· ZTWS Registry: Future deployment with warrant-first logic, judicial safe integration, and surveillance reform enforcement

The two contracts are independent. ENS ztws.registry.v1 should point to the ZTWS registry once deployed, not the Genesis anchor unless the architecture intentionally merges them.

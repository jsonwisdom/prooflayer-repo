# ZTWS Deployment Status

## Current State: SCAFFOLD

| Field | Status |
|---|---|
| Network | Base Mainnet (`8453`) |
| Registry Address | `TBD_POST_DEPLOY` |
| Contracts Deployed | `NOT_CONFIRMED` |
| Live | `FALSE` |

## Deployment Manifest

`deploy/manifest.v1.json` contains planned configuration.

Placeholder values indicate the deployment has not yet been executed or finalized.

Examples of placeholder / pending fields:

```text
registry = TBD_POST_DEPLOY
REGISTRY = 0x...
TX_HASH = 0x...
DEPLOY_BLOCK = ...
MANIFEST_CID = ...
```

## When Live

When the registry address is updated from `TBD_POST_DEPLOY` to a real Base address, this file should be updated with:

- deployment transaction hash
- registry contract address
- deployment block
- manifest CID
- contract ABI location
- verification status on Basescan
- signer / owner boundary notes

## Boundary Rule

Until those fields are real and committed, this repository is not deployment truth.

Rule: no ghost deployment.

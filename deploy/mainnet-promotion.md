# ZTWS Mainnet Promotion Checklist (Base Mainnet: 8453)

## 1. Environment Preparation
- [ ] Wallet loaded with Base Mainnet ETH for deployment and configuration transactions.
- [ ] Safe initialized with 3-of-5 signers on Base Mainnet.
- [ ] ENS controller rights for `jaywisdom.base.eth` and `jaywisdom.eth` verified.

## 2. Smart Contract Deployment
- [ ] Deploy `ZTWSWarrantRegistry` to Base Mainnet.
- [ ] Record `REGISTRY_ADDRESS` and verify it on BaseScan.

## 3. Infrastructure Binding
- [ ] Set gateway allowlist with `setGateway(address,bool)`.
- [ ] Bind enclave measurement with `setGatewayMeasurement(address,bytes32)`.
- [ ] Lock the L0 bucket retention policy and confirm object versioning.

## 4. ENS Pointer Layer
- [ ] Set `ztws.registry` text record on `jaywisdom.eth`.
- [ ] Set `ztws.chainId` text record to `8453`.
- [ ] Set `ztws.registry` text record on `jaywisdom.base.eth`.
- [ ] Set `ztws.version` and manifest pointer after first live cycle.

## 5. Verification
- [ ] Issue first live warrant via judicial Safe.
- [ ] Confirm `WarrantIssued` on Base Mainnet.
- [ ] Run `watchdog.py` against the mainnet registry.
- [ ] Confirm `ExecutionReceipt` with expected attestation hash.

## 6. Release
- [ ] Update `deploy/manifest.v1.json` with final mainnet registry address.
- [ ] Tag release after first verified mainnet cycle.

from web3 import Web3
import hashlib


def _bind_report_data(query_hash: bytes, warrant_id: bytes) -> bytes:
    return hashlib.sha256(query_hash + warrant_id).digest()


def can_execute(contract, warrant_id, chain_id):
    w = contract.functions.warrants(warrant_id).call()
    predicate_hash, gcs_hash, judicial_multisig, valid_until, max_queries, queries_used, warrant_chain_id, nonce, active, revoked = w
    if not active or revoked:
        return {"ok": False, "reason": "inactive"}
    if int(warrant_chain_id) != int(chain_id):
        return {"ok": False, "reason": "chain_id"}
    now = contract.w3.eth.get_block("latest")["timestamp"]
    if now > valid_until:
        return {"ok": False, "reason": "expired"}
    if queries_used >= max_queries:
        return {"ok": False, "reason": "limit"}
    return {"ok": True, "gcs_hash": gcs_hash, "predicate_hash": predicate_hash}


def verify_and_log(contract, gateway_addr, warrant_id, query_hash, result_size, attestation_quote_bytes):
    # 1) preflight checks against chain state
    chk = can_execute(contract, warrant_id, contract.w3.eth.chain_id)
    if not chk.get("ok"):
        return {"ok": False, "stage": "preflight", "reason": chk.get("reason")}

    # 2) bind report_data to this query + warrant
    report_data = _bind_report_data(query_hash, warrant_id)

    # 3) derive attestation hash from fresh quote (placeholder for Nitro/SGX verification)
    # In production, verify the quote signature and ensure report_data is embedded
    att_hash = hashlib.sha256(attestation_quote_bytes + report_data).digest()

    # 4) check registered measurement on-chain
    reg = contract.functions.gatewayMeasurements(gateway_addr).call()
    if reg == bytes(32):
        return {"ok": False, "stage": "attestation", "reason": "unregistered_gateway"}
    if reg != att_hash:
        return {"ok": False, "stage": "attestation", "reason": "measurement_mismatch"}

    # 5) submit execution receipt
    tx = contract.functions.recordExecution(
        warrant_id,
        query_hash,
        int(result_size),
        att_hash
    ).build_transaction({})

    return {"ok": True, "tx": tx, "attestation_hash": att_hash.hex()}
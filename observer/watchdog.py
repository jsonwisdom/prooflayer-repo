import os
import time
import json
from web3 import Web3

RPC_URL = os.environ.get("RPC_URL")
REGISTRY_ADDRESS = os.environ.get("REGISTRY_ADDRESS")

w3 = Web3(Web3.HTTPProvider(RPC_URL))
contract = w3.eth.contract(address=Web3.to_checksum_address(REGISTRY_ADDRESS), abi=[])

issued_warrants = set()
gateway_measurements = {}
executed = set()


def alert(kind, payload):
    print(json.dumps({"kind": kind, **payload}, sort_keys=True))


def process_warrant(event):
    wid = event['args']['warrantId']
    issued_warrants.add(wid)


def process_gateway(event):
    gw = event['args']['gateway']
    m = event['args']['measurement']
    gateway_measurements[gw] = m


def process_execution(event):
    wid = event['args']['warrantId']
    gw = event['address']
    att = event['args'].get('attestationHash')

    if wid not in issued_warrants:
        alert("SHADOW_QUERY", {"reason": "no_warrant", "warrantId": wid.hex(), "tx": event['transactionHash'].hex(), "block": event['blockNumber']})
        return

    if gw not in gateway_measurements or gateway_measurements[gw] != att:
        alert("SHADOW_QUERY", {"reason": "measurement_mismatch", "gateway": gw, "tx": event['transactionHash'].hex(), "block": event['blockNumber']})
        return

    executed.add(wid)


def main():
    print(json.dumps({"status": "watchdog_started"}))
    while True:
        # placeholder polling loop; replace with real filters
        time.sleep(5)


if __name__ == "__main__":
    main()

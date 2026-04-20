// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";

interface IRegistry {
    function issueWarrant(
        bytes32 warrantId,
        address agent,
        bytes32 predicateHash,
        bytes32 gcsHash,
        address judicialMultisig,
        uint64 validUntil,
        uint32 maxQueries,
        bytes32 nonce
    ) external;
}

contract IssueTestWarrant is Script {
    function run() external {
        uint256 pk = vm.envUint("SAFE_PROPOSER_PK");
        address registry = vm.envAddress("REGISTRY");
        address agent = vm.envAddress("AGENT");
        address judicial = vm.envAddress("JUDICIAL_SAFE");
        bytes32 predicateHash = vm.envBytes32("PREDICATE_HASH");
        bytes32 gcsHash = vm.envBytes32("GCS_HASH");
        uint64 validUntil = uint64(vm.envUint("VALID_UNTIL"));
        uint32 maxQueries = uint32(vm.envUint("MAX_QUERIES"));

        bytes32 nonce = keccak256(
            abi.encode(block.chainid, block.timestamp, agent, predicateHash, gcsHash)
        );

        bytes32 warrantId = keccak256(
            abi.encode(
                block.chainid,
                registry,
                agent,
                predicateHash,
                gcsHash,
                validUntil,
                maxQueries,
                nonce
            )
        );

        vm.startBroadcast(pk);
        IRegistry(registry).issueWarrant(
            warrantId,
            agent,
            predicateHash,
            gcsHash,
            judicial,
            validUntil,
            maxQueries,
            nonce
        );
        vm.stopBroadcast();
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract ZTWSWarrantRegistry {
    error UnauthorizedIssuer();
    error UnauthorizedGateway();
    error MeasurementMismatch();
    error WarrantExists();
    error WarrantInactive();
    error WarrantExpired();
    error QueryLimitReached();

    struct Warrant {
        bytes32 predicateHash;
        bytes32 gcsHash;
        address judicialMultisig;
        uint64 validUntil;
        uint32 maxQueries;
        uint32 queriesUsed;
        uint256 chainId;
        bytes32 nonce;
        bool active;
        bool revoked;
    }

    address public owner;
    address public judicialIssuer;

    mapping(bytes32 => Warrant) public warrants;
    mapping(address => bool) public gateways;
    mapping(address => bytes32) public gatewayMeasurements;
    mapping(address => uint256) public lastAttestationBlock;

    event WarrantIssued(bytes32 indexed warrantId, address indexed agent, bytes32 predicateHash, bytes32 gcsHash, address judicialMultisig, uint64 validUntil, uint32 maxQueries, uint256 chainId, bytes32 nonce, uint256 ts);
    event ExecutionReceipt(bytes32 indexed warrantId, bytes32 indexed queryHash, uint32 queriesUsed, uint256 ts, uint256 resultSize, bytes32 attestationHash);
    event GatewayMeasurementSet(address indexed gateway, bytes32 measurement, uint256 blockNo);
    event GatewaySet(address indexed gateway, bool allowed);
    event WarrantRevoked(bytes32 indexed warrantId, uint256 ts);

    modifier onlyOwner() {
        require(msg.sender == owner, "owner");
        _;
    }

    modifier onlyJudicialIssuer() {
        if (msg.sender != judicialIssuer) revert UnauthorizedIssuer();
        _;
    }

    constructor(address _judicialIssuer) {
        owner = msg.sender;
        judicialIssuer = _judicialIssuer;
    }

    function setGateway(address gateway, bool allowed) external onlyOwner {
        gateways[gateway] = allowed;
        emit GatewaySet(gateway, allowed);
    }

    function setGatewayMeasurement(address gateway, bytes32 measurement) external onlyOwner {
        gatewayMeasurements[gateway] = measurement;
        lastAttestationBlock[gateway] = block.number;
        emit GatewayMeasurementSet(gateway, measurement, block.number);
    }

    function issueWarrant(bytes32 warrantId, address agent, bytes32 predicateHash, bytes32 gcsHash, address judicialMultisig, uint64 validUntil, uint32 maxQueries, bytes32 nonce) external onlyJudicialIssuer {
        if (warrants[warrantId].judicialMultisig != address(0)) revert WarrantExists();
        warrants[warrantId] = Warrant(predicateHash, gcsHash, judicialMultisig, validUntil, maxQueries, 0, block.chainid, nonce, true, false);
        emit WarrantIssued(warrantId, agent, predicateHash, gcsHash, judicialMultisig, validUntil, maxQueries, block.chainid, nonce, block.timestamp);
    }

    function revokeWarrant(bytes32 warrantId) external onlyJudicialIssuer {
        warrants[warrantId].revoked = true;
        warrants[warrantId].active = false;
        emit WarrantRevoked(warrantId, block.timestamp);
    }

    function recordExecution(bytes32 warrantId, bytes32 queryHash, uint256 resultSize, bytes32 attestationHash) external {
        if (!gateways[msg.sender]) revert UnauthorizedGateway();
        if (gatewayMeasurements[msg.sender] == bytes32(0)) revert UnauthorizedGateway();
        if (gatewayMeasurements[msg.sender] != attestationHash) revert MeasurementMismatch();

        Warrant storage w = warrants[warrantId];
        if (!w.active || w.revoked) revert WarrantInactive();
        if (block.timestamp > w.validUntil) revert WarrantExpired();
        if (w.queriesUsed >= w.maxQueries) revert QueryLimitReached();

        w.queriesUsed += 1;
        lastAttestationBlock[msg.sender] = block.number;
        emit ExecutionReceipt(warrantId, queryHash, w.queriesUsed, block.timestamp, resultSize, attestationHash);
    }
}

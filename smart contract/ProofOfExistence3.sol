pragma solidity ^0.4.4;

// Proof of Existence contract, version 3

contract ProofOfExistence3 {

    mapping (bytes32 => bool) private proofs;

    // store a proof of existence in the contract state
    function storeProof(bytes32 proof) {
        proofs[proof] = true;
    }

    // calculate and store the proof for a document
    // ** transactional function **
    // A transaction function perfrom a state change within the
    // contract or move funds. As these state changes need be
    // reflected in the blockchain, transaction fucntions
    // require gas.
    function notarize(string document) {
        var proof = proofFor(document);
        storeProof(proof);
    }


    // helper function to get sha256 for a document
    // ** read-only function **
    // A read-only function cost no gas and runs locally on
    // each node in the network. These functions only perfrom
    // computations and return values. They do not effect the
    // blockchain.
    function proofFor(string document) constant returns (bytes32) {
        return sha256(document);
    }

    function testCheckDocument(string document) constant returns (bytes32) {
        var proof = proofFor(document);
        if (hasProof(proof)) {
            return "true";
        } else {
            return "false";
        }
    }

    // check if a document has been notarized
    function checkDocument(string document) constant returns (bool) {
        var proof = proofFor(document);
        return hasProof(proof);
    }

    // returns true if proof is stored
    function hasProof(bytes32 proof) constant returns(bool) {
        return proofs[proof];
    }
}

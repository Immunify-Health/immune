module immune_addr::ehrIndexer {
    use aptos_framework::randomness;
    use aptos_framework::object; 
    use aptos_std::aptos_hash;
    use aptos_std::smart_vector;
    use aptos_std::smart_vector::SmartVector;
    use aptos_std::secp256k1;
    use aptos_std::secp256k1::ECDSASignature;
    use std::signer;
    use std::error;
    use std::string::{String, Self};
    use std::option;
    use 0x1::simple_map::{Self, SimpleMap};
    // use aptos_token_objects::token::{Self, Token};
    // use aptos_token_objects::royalty;

    use immune_addr::ownable;

    // Error codes
    const ADL: u64 = 0; // already deleted
    const WTP: u64 = 1; // wrong type passed
    const LST: u64 = 2; // new version of the EHR document must be the latest
    const NFD: u64 = 3; // not found
    const AEX: u64 = 4; // already exists
    const DND: u64 = 5; // access denied
    const TMT: u64 = 6; // timeout
    const NNC: u64 = 7; // wrong nonce
    const SIG: u64 = 8; // invalid signature
    

    /// Represents a single entry of data within the patient record.
    struct DataEntry has store {
        /// Identifier for the group to which this entry belongs.
        groupID: u64,
        /// Mapping from string keys to vectors of bytes representing values.
        valueSet: SimpleMap<String, SmartVector<u8>>,
        /// Encrypted document storage identifier for this entry.
        docStorIDEncr: SmartVector<u8>,
    }

    /// Represents an element within the patient record structure.
    struct Element has key, store {
        /// Type of item within the patient record.
        itemType: SmartVector<u8>,
        /// Type of element within the patient record.
        elementType: SmartVector<u8>,
        /// Identifier for the node to which this element belongs.
        nodeID: SmartVector<u8>,
        /// Name of the element.
        name: SmartVector<u8>,
        /// Collection of data entries associated with this element.
        dataEntries: SmartVector<DataEntry>,
    }

    /// Represents a node within the patient record structure.
    struct Node has key {
        /// Type of the node within the patient record.
        nodeType: SmartVector<u8>,
        /// Identifier for this node within the patient record.
        nodeID: SmartVector<u8>,
        /// Mapping from vectors of bytes representing items to elements within this node.
        items: SimpleMap<SmartVector<u8>, Element>,
    }

    /// Represents a user within the decentralized patient record system.
    struct User {
        /// Unique identifier for the user.
        id: u64,
        /// Identifier for the system to which the user belongs.
        systemID: u64,
        /// Role assigned to the user within the patient record system.
        role: u64,
        /// Hash of the user's password for authentication.
        pwdHash: SmartVector<u8>,
    }

    /// Represents a group of users within the patient record system.
    struct UserGroup {
        /// Mapping from parameter identifiers to parameter values for this user group.
        params: SimpleMap<u32, u32>,
        /// Total count of members in this user group.
        membersCount: u64,
    }

    /// Represents an indexer for managing users, user groups, and related entities within the patient record system.
    struct Indexer {
        /// Mapping from addresses to user information within the patient record system.
        users: SimpleMap<address, User>,
        /// Mapping from user identifiers to EHR users within the patient record system.
        ehrUsers: SimpleMap<u32, u32>,
        /// Mapping from group identifiers to user group information within the patient record system.
        userGroups: SimpleMap<u32, UserGroup>,
    }

        

    public fun init (addr: address): address {
        let dataSearch: Node;

        ownable::owner(addr)
    
    }

    public entry fun setEhrUser(
        userId: u8,
        ehrId: u64,
        message: vector<u8>,
        signatory: signer,
        signature: vector<u8>,
    ) {

        // let nonce = randomness::u64_integer();
        let parse_sig: secp256k1::ECDSASignature = secp256k1::ecdsa_signature_from_bytes(signature);

        // let inputs = vector[
        //     b"setEhrUser",
        //     userId,
        //     ehrId,
        //     nonce
        // ];

        // let hash_msg = aptos_hash::
        let verify = secp256k1::ecdsa_recover(message, userId, &parse_sig);
        // let pk_to_bytes = secp256k1::ecdsa_raw_public_key_to_bytes(&verify);
        // assert!()

    }

//     function setEhrUser(
//     bytes32 userId, 
//     bytes32 ehrId,
//     uint nonce, 
//     address signer, 
//     bytes memory signature
//   ) 
//     external onlyAllowed(msg.sender) checkNonce(signer, nonce)
//   {
//     // Signature verification
//     bytes32 payloadHash = keccak256(abi.encode("setEhrUser", userId, ehrId, nonce));
//     require(SignChecker.signCheck(payloadHash, signer, signature), "SIG");

//     ehrUsers[userId] = ehrId;
//   }

    // Randdomness for nonce generation.
    // public fun setEhrUser() {
    //     // userId: bytes,
    //     ehrId: u64,
    //     uint: nonce,
    // } {}

    
    
}
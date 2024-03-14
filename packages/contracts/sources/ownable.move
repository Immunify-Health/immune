module immune_addr::ownable {
    /**
     * @dev Inspired by OpenZeppelin
     */


    use std::signer;
    use aptos_framework::account;
    // Error codes 
    /**
     * @dev The caller account is not authorized to perform an operation.
     */
    const OWNABLE_UNAUTHORIZED_ACCOUNT: u64 = 100;
    /**
     * @dev The owner is not a valid owner account. (eg. `address(0)`)
     */
    const OWNABLE_INVALID_OWNER: u64 = 101;

    struct Ownerlist has key, drop {
        owner: address,
    }





    /**
     * @dev Returns the address of the current owner.
     */
    public fun owner(addr: address): address acquires Ownerlist {
        borrow_global<Ownerlist>(addr).owner
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    public fun checkOwner(addr: address) acquires Ownerlist {
        assert!(addr == borrow_global<Ownerlist>(addr).owner, OWNABLE_UNAUTHORIZED_ACCOUNT);
    }

    public fun renounceOwnership() {

    }

    public fun transferOwnership() {
        
    }






    #[test(admin = @immune_addr,alice=@0x11,bob=@0x2)]
    fun test_verify_owner(alice: signer, bob: signer) {

        account::create_account_for_test(signer::address_of(&alice));
        account::create_account_for_test(signer::address_of(&bob));

        let owner1 = signer::address_of(&alice);
        let owner2 = signer::address_of(&bob);

        let new_owner = Ownerlist{
            owner: owner1,
        };

        assert!((&new_owner.owner != &owner2), OWNABLE_INVALID_OWNER);
    }


}
// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0 <0.9.0;

contract TechStore {
    address private owner;
    uint256 private funds;


    Payment[] private payments;
    struct Payment {
        address buyer;
        uint256 amount;
    }

    constructor() {
        owner = msg.sender;
    }

    function buyProduct(uint256 productValue) public payable returns (bool) {
        require(
            msg.value >= productValue,
            "you need to pay more ETH..."
        );

        uint spare = msg.value - productValue;
        if (spare > 0) {
            payable(msg.sender).transfer(spare);
        }
        funds += productValue;
        payments.push(Payment(msg.sender, productValue));
        
        return true; 
    }

    function seePayment(uint256 index) public view returns (address, uint256) {
        return (payments[index].buyer, payments[index].amount );
    }

    function seeFunds() public view returns (uint256) {
        return funds;
    }

    function seeOwner() public view returns (address) {
        return owner;
    }

    function extractFunds() public payable onlyOwner returns (bool) {
        payable(msg.sender).transfer(funds);
        funds = 0;
        return true;
    }

    modifier onlyOwner {
        require(
            msg.sender == owner,
            "you don't have permission for this."
        );
        _;
    }
}
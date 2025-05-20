//SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract TokenDeposit {

    address LackOfAddress;
    mapping(address => uint) Interactions;

    struct SpecificTransaction {
        uint _ValueStoredAtTheTime;
        uint _SpecificDepositValue;
        uint _SpecificWithDrawlValue;
        address _RecipientValue;
        uint _SpecificTimeStamp;
    }

    mapping (address => mapping(uint => SpecificTransaction)) public specifictransaction;

    struct Transactions{
        uint _ValueStored;
        uint _LatestDepositValue;
        uint _WithdrawlValue;
        uint _WithdrawlRecipient;
        uint _TransactionTime;
        uint _TransactionNumber;
    }

    mapping (address => Transactions) public transaction;

    function DepositMoney () public payable {
        transaction[msg.sender]._LatestDepositValue = msg.value;
        transaction[msg.sender]._ValueStored += msg.value;
        transaction[msg.sender]._TransactionTime = block.timestamp;
        Interactions[msg.sender]++;
        transaction[msg.sender]._TransactionNumber = Interactions[msg.sender];
        specifictransaction[msg.sender][Interactions[msg.sender]] = SpecificTransaction(transaction[msg.sender]._ValueStored, transaction[msg.sender]._LatestDepositValue, 0, LackOfAddress, transaction[msg.sender]._TransactionTime);
    }
    
    function WithdrawMoney (address ToWhom, uint AmountToWithdraw) public {
        require(AmountToWithdraw <= transaction[msg.sender]._ValueStored && AmountToWithdraw > 0, "Transfer amount exceeds or is below a valid quantity");
        payable(ToWhom).call{value: AmountToWithdraw}("");
        transaction[msg.sender]._ValueStored -= AmountToWithdraw;   
        transaction[msg.sender]._WithdrawlValue = AmountToWithdraw;
        transaction[msg.sender]._TransactionTime = block.timestamp;
        Interactions[msg.sender]++;
        transaction[msg.sender]._TransactionNumber = Interactions[msg.sender];
        specifictransaction[msg.sender][Interactions[msg.sender]] = SpecificTransaction(transaction[msg.sender]._ValueStored, 0, transaction[msg.sender]._WithdrawlValue = AmountToWithdraw, ToWhom, transaction[msg.sender]._TransactionTime);
    }
}

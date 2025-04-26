//SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract MoneyDepositSmartContract {

    uint public totalmoneydepositedbyall;

    mapping(address => uint) public UserBalance;

    mapping(address => uint) public ElegeableToWithDraw;

    fallback() external payable {

        UserBalance[msg.sender] += msg.value;

        totalmoneydepositedbyall += msg.value;

     }

    function depositemoney() public payable {

        UserBalance[msg.sender] += msg.value;

        totalmoneydepositedbyall += msg.value;

    }

    function withdrawmoney(uint amount_to_withdraw) public {

        if(UserBalance[msg.sender] > 0){

            ElegeableToWithDraw[msg.sender] = UserBalance[msg.sender];

            UserBalance[msg.sender] = 0;

            payable (msg.sender).call{value: ElegeableToWithDraw[msg.sender]}("");

        }

    }

    function sendmoney(uint amount_to_give, address who_to_give) public {

        if(UserBalance[msg.sender] > 0) {

            ElegeableToWithDraw[msg.sender] = UserBalance[msg.sender] - amount_to_give;

            UserBalance[msg.sender] - amount_to_give;

            payable (who_to_give).call{value: amount_to_give}("");

        }

    }

}

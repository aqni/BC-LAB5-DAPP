// Please paste your contract's solidity code here
// Note that writing a contract here WILL NOT deploy it and allow you to access it from your client
// You should write and develop your contract in Remix and then, before submitting, copy and paste it here

pragma solidity ^0.5.0; //版本太高会出现问题

contract Splitwise {

    mapping(address=>mapping(address=>uint32)) private debtors;
  
    function lookup(address debtor, address creditor) public view returns (uint32 ret){
        return debtors[debtor][creditor];
    }

    function add_IOU(address creditor, uint32 amount, address[] memory offsetPath, uint32 offset) public{
        //debtor is msg.sender
        require(amount >= offset);
        debtors[msg.sender][creditor] += amount-offset;

        for(uint i=1; i< offsetPath.length; i++){
            address d=offsetPath[i-1];
            address c=offsetPath[i];
            require(debtors[d][c] >= offset);
            debtors[d][c] -= offset;
        }
    }
}
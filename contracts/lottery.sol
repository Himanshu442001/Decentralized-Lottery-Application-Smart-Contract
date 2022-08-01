//SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract lottery{
    address public manager;
    address payable[] public participants;




    constructor(){
        manager=msg.sender;   //Global Variable

    }

    // Receive function can be only used once in a contract with external keyword

    receive() external payable
    {
        require(msg.value==0.004 ether);
        participants.push(payable(msg.sender));

    }

    function getBalance() public view returns (uint){
        require(msg.sender==manager);
        return address(this).balance;
    }

    // Keccak 256 Algorithm computes  keccak-256 hash of the input

    function random()  public view returns(uint){
      return  uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participants.length)));

    }

    function selectWinner() public {
        require(msg.sender==manager);
        require(participants.length>=3);   
        uint r=random();

        address payable winner;
        uint index = r % participants.length;
        winner=participants[index];
        winner.transfer(getBalance());
        participants=new address payable[](0);
        

    }




}
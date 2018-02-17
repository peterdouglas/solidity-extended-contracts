pragma solidity ^0.4.17;

import "./LockableToken.sol";

contract DemoToken is LockableToken {
  function DemoToken(uint _initialSupply) public {
    totalSupply = _initialSupply;
    balances[msg.sender] = _initialSupply;
  }
}
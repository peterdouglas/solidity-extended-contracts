pragma solidity ^0.4.17;

// This token is based on BurnableToken.sol
import "../installed_contracts/zeppelin/contracts/token/StandardToken.sol";


/**
 * @title Lockable Token
 * @dev Token that can have balances locked.
 *      This is primarily useful for systems that require token transfers between different networks
 */
contract LockableToken is StandardToken {
  uint lockedSupply_ = 0;
  mapping(address=>uint) lockedBalances;

  event TokenLock(address indexed locker, uint256 value);
  event TokenUnlock(address indexed unlocker, uint256 value);

  /**
   * @dev returns the amount of currently locked tokens.
   */
  function lockedSupply() view public returns (uint) {
    return lockedSupply_;
  }

  /**
   * @dev locks a specific amount of tokens.
   * @param _value The amount of tokens to be locked.
   */
  function lock(uint256 _value) public {
    require(_value <= balances[msg.sender]);

    address locker = msg.sender;
    balances[locker] = balances[locker].sub(_value);
    lockedBalances[locker] = lockedBalances[locker].add(_value);
    lockedSupply_ = lockedSupply_.add(_value);
    TokenLock(locker, _value);
  }

  /**
   * @dev unlocks a specific amount of tokens.
   * @param _value The amount of tokens to be unlocked.
   */
  function unlock(uint256 _value) public {
    require(_value <= lockedBalances[msg.sender]);

    address unlocker = msg.sender;
    lockedSupply_ = lockedSupply_.sub(_value);
    balances[unlocker] = balances[unlocker].add(_value);
    TokenUnlock(unlocker, _value);
  }
}
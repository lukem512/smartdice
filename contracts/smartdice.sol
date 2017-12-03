// SMARTDICE
// Luke Mitchell <hi@lukemitchell.co>

pragma solidity ^0.4.11;
import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";

contract SmartDice is usingOraclize {

    address owner;
    event diceRolled(bytes32 id, uint value);

    function SmartDice() payable {
        rollDice();
        owner = msg.sender;
    }

    function __callback(bytes32 id, string value) {
        if (msg.sender != oraclize_cbAddress()) throw;
        diceRolled(id, parseInt(value));
    }

    function getPrice() returns (uint) {
        // Retrieve price for oraclize query
        return oraclize_getPrice("WolframAlpha");
    }

    function rollDice() payable returns (bytes32) {
        // Check the price is covered by the transaction
        if (msg.value < getPrice()) {
          throw;
        }

        // Call WolframAlpha via Oraclize to roll the dice
        return oraclize_query("WolframAlpha", "random number between 1 and 6");
    }

    function withdraw(uint amount) returns (bool) {
        // Only the owner may withdraw
        if (msg.sender != owner) {
            return false;
        }

        // Sanity check balance
        if (amount > this.balance) {
            return false;
        }

        // Try to send, throw if
        if (!msg.sender.send(amount)) {
            return false;
        }

        return true;
    }
}

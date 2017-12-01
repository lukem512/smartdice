pragma solidity ^0.4.11;
import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";

contract SmartDice is usingOraclize {

    string public lastRoll;
    string public lastPrice;
    event diceRolled(uint value);
    event message(string description);

    function SmartDice() payable {
        rollDice();
    }

    function __callback(bytes32 myid, string result) {
        if (msg.sender != oraclize_cbAddress()) throw;
        lastRoll = result;
        diceRolled(parseInt(lastRoll));
    }

    function rollDice() payable {
        // Retrieve price for oraclize query
        uint oraclizePrice = oraclize_getPrice("WolframAlpha");
        
        // Throw if not covered by the sender
        if (msg.value < oraclizePrice) throw;
        
        // Sanity check contract balance is sufficient
        if (oraclizePrice > this.balance) {
            message("Could not retrieve random number, please add some ETH to cover the query fee");
        } else {
            lastPrice = uint2str(oraclizePrice);
            message("Rolling the dice...");
            oraclize_query("WolframAlpha", "random number between 1 and 6");
        }
    }
}

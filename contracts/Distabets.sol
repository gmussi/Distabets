// SPDX-License-Identifier: MIT
pragma solidity >=0.8.6;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Distabets is Ownable {
    event MarketCreated(address indexed creator, uint indexed marketId, string name);

    uint256 public constant ONE = 10**18;

    struct Market {
        // market details
        string title;
        uint numOutcomes;
        mapping(uint256 => MarketOutcome) outcomes;
        // total stake
    }

    struct MarketOutcome {
        // outcome details
        uint256 marketId;
        uint256 id;
        bytes32 outcomeName;
        mapping(address => uint256) holders;
    }

    uint256[] marketIds;
    mapping(uint256 => Market) markets;
    uint256 public marketIndex;

    function createMarket(string calldata _title, bytes32[] memory _outcomeNames) external payable returns(uint256) {
        //require(msg.value > 0, "stake needs to be > 0");

        uint256 marketId = marketIndex;
        marketIds.push(marketId);

        Market storage market = markets[marketId];
        market.title = _title;
        market.numOutcomes = _outcomeNames.length;

        for (uint i = 0; i < _outcomeNames.length; i++) {
            MarketOutcome storage outcome = market.outcomes[i];
            outcome.marketId = marketId;
            outcome.id = i;
            outcome.outcomeName = _outcomeNames[i];
        }

        marketIndex = marketIndex + 1;
        return marketId;
    }

    function getMarket(uint256 _marketId) public view returns (string memory, bytes32[] memory) {
        Market storage market = markets[_marketId];
        
        bytes32[] memory outcomeNames = new bytes32[](market.numOutcomes);

        for (uint i = 0; i < market.numOutcomes; i++) {
            outcomeNames[i] = (market.outcomes[i].outcomeName);
        }
        return (market.title, outcomeNames);
    }


}
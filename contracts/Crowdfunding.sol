// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Crowdfunding
 * @dev A simple blockchain-based crowdfunding smart contract.
 * Contributors can send ETH to a campaign.
 * The campaign owner can withdraw the money if the funding goal is reached.
 * Contributors can claim a refund if the campaign fails.
 */

contract Crowdfunding {

    // Address of the person who created the campaign
    address payable public owner;

    // Name of the crowdfunding campaign
    string public campaignName;

    // Amount of ETH the campaign wants to raise
    uint256 public fundingGoal;

    // Time when the campaign ends
    uint256 public deadline;

    // Total amount of ETH contributed
    uint256 public totalRaised;

    // Records how much each address contributed
    mapping(address => uint256) public contributions;

    // Prevents the owner from withdrawing more than once
    bool public fundsWithdrawn;

    // Event emitted whenever someone contributes
    event ContributionReceived(
        address indexed contributor,
        uint256 amount
    );

    // Event emitted when the campaign owner withdraws the funds
    event FundsWithdrawn(
        address indexed owner,
        uint256 amount
    );

    // Event emitted when a contributor receives a refund
    event RefundIssued(
        address indexed contributor,
        uint256 amount
    );

    /**
     * @dev Creates a new crowdfunding campaign.
     * @param _campaignName Name of the campaign.
     * @param _fundingGoal Funding goal in Wei.
     * @param _durationInDays Number of days the campaign will run.
     */
    constructor(
        string memory _campaignName,
        uint256 _fundingGoal,
        uint256 _durationInDays
    ) {
        require(
            _fundingGoal > 0,
            "Funding goal must be greater than zero"
        );

        require(
            _durationInDays > 0,
            "Duration must be greater than zero"
        );

        owner = payable(msg.sender);
        campaignName = _campaignName;
        fundingGoal = _fundingGoal;

        // Convert campaign duration from days to seconds
        deadline = block.timestamp + (_durationInDays * 1 days);
    }

    /**
     * @dev Allows users to contribute ETH to the campaign.
     */
    function contribute() external payable {

        require(
            block.timestamp < deadline,
            "Crowdfunding campaign has ended"
        );

        require(
            msg.value > 0,
            "Contribution must be greater than zero"
        );

        contributions[msg.sender] += msg.value;
        totalRaised += msg.value;

        emit ContributionReceived(msg.sender, msg.value);
    }

    /**
     * @dev Allows the campaign owner to withdraw the funds
     * if the funding goal has been reached.
     */
    function withdrawFunds() external {

        require(
            msg.sender == owner,
            "Only the campaign owner can withdraw funds"
        );

        require(
            totalRaised >= fundingGoal,
            "Funding goal has not been reached"
        );

        require(
            !fundsWithdrawn,
            "Funds have already been withdrawn"
        );

        fundsWithdrawn = true;

        uint256 amount = address(this).balance;

        (bool success, ) = owner.call{value: amount}("");

        require(
            success,
            "Withdrawal failed"
        );

        emit FundsWithdrawn(owner, amount);
    }

    /**
     * @dev Allows contributors to receive their money back
     * if the campaign ends without reaching the funding goal.
     */
    function claimRefund() external {

        require(
            block.timestamp >= deadline,
            "Campaign has not ended yet"
        );

        require(
            totalRaised < fundingGoal,
            "Funding goal was reached"
        );

        uint256 amount = contributions[msg.sender];

        require(
            amount > 0,
            "No contribution available for refund"
        );

        // Set contribution to zero before transferring
        // to protect against re-entrancy
        contributions[msg.sender] = 0;

        (bool success, ) =
            payable(msg.sender).call{value: amount}("");

        require(
            success,
            "Refund failed"
        );

        emit RefundIssued(msg.sender, amount);
    }

    /**
     * @dev Returns the current status of the campaign.
     */
    function getCampaignStatus()
        external
        view
        returns (string memory)
    {
        if (fundsWithdrawn) {
            return "Funds withdrawn successfully";
        }

        if (totalRaised >= fundingGoal) {
            return "Funding goal reached";
        }

        if (block.timestamp >= deadline) {
            return "Campaign ended - goal not reached";
        }

        return "Campaign is active";
    }
} 
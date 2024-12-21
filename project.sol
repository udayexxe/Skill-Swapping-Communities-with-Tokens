// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import OpenZeppelin's ERC20 token contract
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Contract for Skill Swapping with Tokens
contract SkillSwapToken is ERC20 {
    address public admin;

    // Mapping to track user skills
    mapping(address => string[]) public userSkills;

    // Constructor to initialize token with a name and symbol
    constructor() ERC20("SkillSwapToken", "SST") {
        admin = msg.sender;
        _mint(msg.sender, 1000000 * 10 ** decimals()); // Mint initial tokens to admin
    }

    // Function to allow users to add skills
    function addSkill(string memory skill) public {
        userSkills[msg.sender].push(skill);
    }

    // Function to swap skills between two users, transferring tokens as a reward
    function swapSkills(address to, uint256 tokenAmount) public {
        require(balanceOf(msg.sender) >= tokenAmount, "Insufficient balance");
        require(userSkills[msg.sender].length > 0 && userSkills[to].length > 0, "Both users must have skills to swap");

        // Transfer tokens as payment
        _transfer(msg.sender, to, tokenAmount);
    }

    // Admin function to mint more tokens to an address
    function mint(address to, uint256 amount) public {
        require(msg.sender == admin, "Only admin can mint tokens");
        _mint(to, amount);
    }

    // Admin function to burn tokens from an address
    function burn(address from, uint256 amount) public {
        require(msg.sender == admin, "Only admin can burn tokens");
        _burn(from, amount);
    }

    // Function to view the skills of a user
    function viewSkills(address user) public view returns (string[] memory) {
        return userSkills[user];
    }
}

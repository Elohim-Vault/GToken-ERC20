pragma solidity ^0.8.0;

contract GToken {
    mapping (address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;
    uint256 totalSupply_;

    event Transfer(address sender, address receiver, uint256 amount);
    event Approval(address owner, address delegate, uint256 amount);

    constructor (uint256 total) public {
        totalSupply_ = total;
        balances[msg.sender] = totalSupply_;
    }

    // TODO: Get total token supply
    function totalSupply() public view returns (uint) {
        return totalSupply_;
    }

    // TODO: Get token balance of owner
    function balanceOf(address tokenOwner) public view returns (uint) {
        return balances[tokenOwner];
    }

    // TODO: Transfer Tokens to another account
    function transfer (address receiver, uint256 amount) public returns (bool) {
        require(amount <= balanceOf(msg.sender));
        balances[receiver] += amount;
        balances[msg.sender] -= amount;
        emit (msg.sender, receiver, amount);
        return true;
    }

    function approve(address delegate, uint256 amount) public returns (bool) {
        allowed[msg.sender][delegate] = amount;
        emit Approval(msg.sender, delegate, amount);
        return true;
    }

    function allowance(address owner, address delegate) public view returns (uint) {
        return allowed[owner][delegate];
    }

    function transferFrom(address owner, address buyer, uint256 amount) public returns (bool) {
        require(amount <= balanceOf(owner));
        require(amount <= allowed[owner][msg.sender]);
        balances[owner] -= amount;
        allowed[owner][msg.sender] -= amount;
        balances[buyer] += amount;
        emit Transfer(owner, buyer, amount);
        return true;
    }
}
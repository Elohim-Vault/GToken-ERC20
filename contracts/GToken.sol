// "SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";


contract GToken {
    using SafeMath for uint256;

    mapping (address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;
    string public constant _name = "GToken";
    string public constant _symbol = "GT";
    uint256 _totalSupply;

    event Transfer(address sender, address receiver, uint256 amount);
    event Approval(address owner, address delegate, uint256 amount);

    constructor (uint256 total) {
        _totalSupply = total;
        balances[msg.sender] = _totalSupply;

    }

    function totalSupply() public view returns (uint) {
        return _totalSupply;
    }

    function balanceOf(address tokenOwner) public view returns (uint) {
        return balances[tokenOwner];
    }


    function transfer (address receiver, uint256 amount) public returns (bool) {
        require(amount <= balanceOf(msg.sender));
        balances[msg.sender].sub(amount);
        balances[receiver].add(amount);

        emit Transfer(msg.sender, receiver, amount);
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
        require(amount <= allowed[owner][buyer]);
        balances[owner].sub(amount);
        allowed[owner][buyer].sub(amount);
        balances[buyer].add(amount);
        emit Transfer(owner, buyer, amount);
        return true;
    }
}
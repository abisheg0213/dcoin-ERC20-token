// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}
contract Decybertoken is IERC20
{
    string public symbol;
    string public name;
    uint public decimals;
    uint private totalsupply;
    mapping (address => uint)Balance;
    mapping (address=> mapping(address=>uint))allowed;
    constructor()
    {
        name="D-Coin";
        symbol="D&C";
        decimals=18;
        totalsupply=1_000_000_000_000_000_000;
        Balance[msg.sender]=totalsupply;
    }
        function totalSupply() external view returns (uint256)
        {
            return totalsupply;
        }
         function balanceOf(address account) external view returns (uint256)
         {
             return Balance[account];
         }
        function transfer(address to, uint256 amount) external returns (bool)
        {
            require(Balance[msg.sender]>=amount, "insufficient balance");
            Balance[msg.sender]=Balance[msg.sender]-amount;
            Balance[to]+=amount;
            emit Transfer(msg.sender, to, amount);
            return true;
        } 
        function approve(address spender, uint256 amount) external returns (bool)
        {
            require(Balance[msg.sender]>=amount, "insufficient balance");
            allowed[msg.sender][spender]=amount;
            emit Approval(msg.sender, spender, amount);
            return true;
        }
        function allowance(address owner, address spender) external view returns (uint256)
        {
            return allowed[owner][spender];
        }
        function transferFrom(address from, address to, uint256 amount) external returns (bool)
        {
             Balance[from]=Balance[from]-amount;
             allowed[from][msg.sender]-=amount;
             Balance[to]+=amount;
             emit Transfer(from, to, amount);
             return true;
        }
}

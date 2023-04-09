pragma solidity ^0.8.14;
interface IERC20 {
    function totalSupply() external view returns (uint);
    function balanceOf(address account) external view returns (uint);
    function transfer(address recipient, uint amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint);
    function approve(address spender, uint amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}
contract dummy is IERC20
{
    uint  totalsuplly;
    uint totalcap;
    mapping(address => uint) balanceof;
    mapping(address=> mapping (address=>uint))public allowance;
    string  name="dcoin";
    string  symbol="d@!c";
    uint decimals=18;
    constructor(uint total,uint t)
    {
        totalsuplly=total;
        balanceof[msg.sender]=totalsuplly;
        totalcap=t;
    }
    function totalSupply() external view returns (uint)
    {
        return totalsuplly;
    }
    function balanceOf(address account) external view returns (uint)
    {
        return balanceof[account];
    }
    function transfer(address recipient, uint amount) external returns (bool)
    {
        balanceof[msg.sender]-=amount;
        balanceof[recipient]+=amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }
    function approve(address spender, uint amount) external returns (bool)
    {
        allowance[msg.sender][spender]=amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool)
    {
        balanceof[sender]-=amount;
        allowance[sender][msg.sender]-=amount;
        balanceof[recipient]+=amount;
        return true;
    }
    function mint(uint nooftokens) public 
    {
        require(totalsuplly+nooftokens<=totalcap);
        balanceof[msg.sender]+=nooftokens;
        totalsuplly+=nooftokens;
    }
    function burn(uint n) public {
        require(balanceof[msg.sender]>=n);
        balanceof[msg.sender]-=n;
        totalsuplly-=n;
    }
}

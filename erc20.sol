
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface ERC20Interface { 
    function totalSupply() external view returns (uint); 
    function balanceOf(address tokenOwner) external view returns (uint balance); 
    function transfer(address to, uint tokens) external returns (bool success);

function allowance(address tokenOwner, address spender) external view returns (uint remaining);
function approve(address spender, uint tokens) external returns (bool success);
function transferFrom(address from, address to, uint tokens) external returns (bool success);

event Transfer(address indexed from, address indexed to, uint tokens);
event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}

contract Block is ERC20Interface{

string public name="SIKK";
string public symbol="SIKK";
string public decimal="0";

uint public override totalSupply;
address public founder;
mapping (address=>uint) public balances;
mapping (address=>mapping(address=>uint)) allowed;
constructor(){
totalSupply=10000000;
founder=msg.sender;
balances[founder]=totalSupply;
}

function balanceOf(address tokenOwner)  public view override returns (uint balance){
    return balances[tokenOwner];
}

function transfer(address to, uint tokens)  public override returns (bool success){
    require(balances[msg.sender]>=tokens);
    balances[to]+=tokens;
    balances[msg.sender]-=tokens;
    emit Transfer(msg.sender,to,tokens);
    return true;
}

function approve(address spender, uint tokens) public override returns (bool success){
require(balances[msg.sender]>=tokens);
require(tokens>0);
allowed[msg.sender][spender]=tokens;
emit Approval(msg.sender,spender,tokens);
return true;
}


function allowance(address tokenOwner, address spender) public view override  returns (uint remaining){
return allowed[tokenOwner][spender];
}


function transferFrom(address from, address to, uint tokens) public override returns (bool success){
    require(allowed[from][to]>=tokens);
    require(balances[from]>=tokens);
    balances[to]+=tokens;
    balances[from]-=tokens;
    return true;
}


}

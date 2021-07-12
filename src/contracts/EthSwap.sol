pragma solidity ^0.5.16;

import "./Token.sol";

contract EthSwap {
    string public name = "EthSwap Instant Exchange";
    Token public token;
    uint public rate = 100;

    constructor(Token _token) public {
        token = _token;
    }
    event TokensPurchase(
        address account,
        address token,
        uint amount,
        uint rate
    );

    event TokensSold(
        address account,
        address token,
        uint amount,
        uint rate
    );
    function buyTokens() public payable {
        // Redemption rate = # of tokens they recive for 1 ether
        // Amount of ethereum * Redemoption rate
        // Calcaulate
        uint tokenAmount = msg.value*rate;
        require(token.balanceOf(address(this)) >= tokenAmount);
        token.transfer(msg.sender, tokenAmount);

        //emit an event
        emit TokensPurchase(msg.sender, address(token), tokenAmount, rate);

    }

    function sellTokens(uint _amount) public {
        //User cant sell more tokens than they have
        require(token.balanceOf(msg.sender) >= _amount);
        //calculate the amount of ether to redeem
        uint etherAmount = _amount / rate;
        //Requiere that EthSwap has enough ether
        require(address(this).balance >= etherAmount);
        //perform sele
        token.transferFrom(msg.sender, address(this), _amount);
        msg.sender.transfer(etherAmount);

        //emit an event
        emit TokensSold(msg.sender, address(token), _amount, rate);

    }

}

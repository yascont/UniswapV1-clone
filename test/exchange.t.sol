// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Token} from "../src/token/token.sol";
import {Exchange} from "../src/Exchange.sol";

contract TokenTest is Test {
    Token public token;
    Exchange public exchange;

    function setUp() public {
        token = new Token("uniswapToken", "yasnUni", 20000);
        exchange = new Exchange(address(token));
        token.approve(address(exchange), 2000);
        exchange.addLiquidity{value : 2000}(2000);
    }

    function test_AddingLiquidity() public {
        require(exchange.getReserve() == 2000, "check initial suply of exchange contract!");
        console.log(" reserve before :", exchange.getReserve());
        token.approve(address(exchange), 110);
        exchange.addLiquidity{value : 100}(100);
        console.log(" reserve after :", exchange.getReserve());
        require(exchange.getReserve() > 2000, "check addLiquidity function!");
    }

    function test_getPrice() view public{


        uint256 price = exchange.getTokenAmount(100);
        console.log(price);
    }

    function test_tokenToEthSwap() public {
        console.log("balace before (token):", token.balanceOf(address(this)));
        // console.log("balace before (eth):",  address(this).balance / 1e18);


        console.log("what u get for for 20 token is", exchange.getEthAmount(20), " eth");


        uint256 previousBalance = token.balanceOf(address(this));

        token.approve(address(exchange), 20);
        exchange.tokenToEthSwap(20, 5);
        require(previousBalance < address(this).balance, "ain't working tokenToEthSwap xD");

        console.log("balace after (token):", token.balanceOf(address(this)));
        // console.log("balace after (eth):",  address(this).balance / 1e18);
        
    }

    function test_addLiquidity() view public {
        console.log("what u get for for 20 token is", exchange.getEthAmount(20), " eth");
    }

    function test_removeLiquidity() public{

        token.approve(address(exchange), 300);
        exchange.addLiquidity{value : 300}(300);

        console.log("test testmove liquidity :");
        console.log("(LP) initial token balance :" , token.balanceOf(address(this)));
        console.log("(LP) initial eth balance :" , address(this).balance);

        console.log("contract total reserves (token) :" , exchange.getReserve());
        console.log("contract total reserves (eth) :" , address(exchange).balance);
        // console.log("what to get for 2 token  :" , exchange.getEthAmount(3), "eth");
        


        token.transfer(address(3), 300);


        vm.startPrank(address(3));
            token.approve(address(exchange), 300);
            exchange.tokenToEthSwap(300, exchange.getEthAmount(300));
        vm.stopPrank();

        exchange.removeLiquidity(300);

        console.log("(LP) token balance after remove :" , token.balanceOf(address(this)));
        console.log("(LP) eth balance after remove :" , address(this).balance );
    }

    receive() external payable{
        console.log("receive function is executed! received :  ", msg.value);


    }

    fallback() external payable{
        console.log("Fallback function is executed!");
    }

}


// x ∗ y = k

//( x + Δx )( y − Δy ) = xy

 



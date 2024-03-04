// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import {FlashLoanSimpleReceiverBase} from "@aave/core-v3/contracts/flashloan/base/FlashLoanSimpleReceiverBase.sol";
import {IPoolAddressesProvider} from "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";
import {IERC20} from "@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20.sol";

interface IDex {
    function depositUSDC(uint256 _amount) external;

    function depositDAI(uint256 _amount) external;

    function buyDAI() external;

    function sellDAI() external;
}

contract FlashLoan is FlashLoanSimpleReceiverBase {
    address payable owner;
    address immutable public daiAddress;
    address immutable public usdcAddress;
    address immutable public dexContractAddress;

    IERC20 private dai;
    IERC20 private usdc;
    IDex dexContract;

    constructor(address _provider, address _daiAddress, address _usdcAddress, address _dexAddress) FlashLoanSimpleReceiverBase(IPoolAddressesProvider(_provider)) {
        owner = payable(msg.sender);
        daiAddress = _daiAddress;
        usdcAddress = _usdcAddress;
        dexContractAddress = _dexAddress;

        dai = IERC20(daiAddress);
        usdc = IERC20(usdcAddress);
        dexContract = IDex(dexContractAddress);
    }

    modifier onlyOwner{
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    function executeOperation(address asset, uint256 amount, uint256 premium, address initiator, bytes calldata params)
        external
        returns (bool)
    {

        // Arbirtage operation
        dexContract.depositUSDC(amount);
        dexContract.buyDAI();
        dexContract.depositDAI(dai.balanceOf(address(this)));
        dexContract.sellDAI();


        // At the end of your logic above, this contract owes
        // the flashloaned amount + premiums.
        // Therefore ensure your contract has enough to repay
        // these amounts.

        uint256 amountOwed = amount + premium;
        IERC20(asset).approve(address(POOL), amountOwed);
        return true;
    }

    function requestFlashLoan(address _token, uint256 _amount) public {
        address receiverAddress = address(this);
        address asset = _token;
        uint256 amount = _amount;
        bytes memory params = "";
        uint16 referralCode = 0;
        POOL.flashLoanSimple(
            receiverAddress,
            asset,
            amount,
            params,
            referralCode
        );
    }

    function getBalance(address _tokenAddress) external view returns(uint256){
        return IERC20(_tokenAddress).balanceOf(address(this));
    }

    function withdraw(address _tokenAddress) public onlyOwner{
        IERC20 token = IERC20(_tokenAddress);
        token.transfer(msg.sender, token.balanceOf(address(this)));
    } 

    function approveUSDC(uint256 _amount) external returns (bool) {
        return usdc.approve(dexContractAddress, _amount);
    }

    function allowanceUSDC() external view returns (uint256) {
        return usdc.allowance(address(this), dexContractAddress);
    }

    function approveDAI(uint256 _amount) external returns (bool) {
        return dai.approve(dexContractAddress, _amount);
    }

    function allowanceDAI() external view returns (uint256) {
        return dai.allowance(address(this), dexContractAddress);
    }

    receive() external payable {

    }





}

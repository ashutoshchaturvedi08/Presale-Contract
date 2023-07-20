// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IBEP20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address _owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 value) external returns (bool);
}

contract PresaleContract  {
    address public owner ;
    IBEP20 public usdtToken ;
    IBEP20 public usdcToken ;
    IBEP20 public token ;
    uint256 public tokenPrice ;
    bool public paused ;
    uint256 public totalTokensSold ;
    uint256 decimals = 18;
    uint256 decimalfactor = 10**uint256(decimals);

    mapping(address => uint256) public balanceOf;
    event TokensPurchased(address buyer, uint256 amount);
   
  

    constructor(address _usdtTokenAddress, address _usdcTokenAddress, address _xyzCoinAddress, uint256 _tokenPrice) {
        owner = msg.sender;
        usdtToken = IBEP20(_usdtTokenAddress);
        usdcToken = IBEP20(_usdcTokenAddress);
        token = IBEP20(_xyzCoinAddress);
         tokenPrice = _tokenPrice;
        
    }


    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can perform this action");
        _;
    }


    function ourTokenBalance() public view onlyOwner returns (uint){
           return token.balanceOf(address(this));
           }


    function USDTBalance() public view onlyOwner returns (uint){
           return usdtToken.balanceOf(address(this));
           }

    function USDCBalance() public view onlyOwner returns (uint){
           return usdcToken.balanceOf(address(this));
           }


    function setTokenPrice(uint _price) public onlyOwner {
          tokenPrice = _price;
          }



    function setPause (bool _value) public onlyOwner {
      paused = _value;
        }


    function setNewTokenAddress(address _token) public onlyOwner {
         token = IBEP20(_token);
        }

 

    function setNewUsdtAddress (address _token) public onlyOwner {
         usdtToken = IBEP20(_token);
      }


    function setNewUsdcAddress (address _token) public onlyOwner {
        
     usdcToken = IBEP20(_token);
    }


    function buyWithUSTD(uint256 _amount) external payable {
        require(_amount > 0, "Invalid token amount");
        require(!paused, "Presale is Paused!!");


        uint256 usdtAllowance = usdtToken.allowance(msg.sender, address(this));
        require(usdtAllowance >= _amount, "Not enough USDT allowance");

        uint256 usdtBalance = usdtToken.balanceOf(msg.sender);
        require(usdtBalance >= _amount, "Not enough USDT balance");

    
        uint256 tokenAmount = _amount / uint256(tokenPrice) * decimalfactor;

        require(token.balanceOf(address(this)) >= tokenAmount, "Insufficient token balance in the contract");

        bool transferSuccess = usdtToken.transferFrom(msg.sender, address(this) , _amount);
        require(transferSuccess, "USDT transfer failed");
        
       
       transferSuccess =  token.transfer(msg.sender, tokenAmount);
       require(transferSuccess, "Coin transfer failed");

        totalTokensSold += tokenAmount;

        emit TokensPurchased(msg.sender, tokenAmount);
    }



    
    function buyWithUSDC(uint256 _amount) external payable {
        require(_amount > 0, "Invalid token amount");
        require(!paused, "Presale is Paused!!");

        uint256 usdcAllowance = usdcToken.allowance(msg.sender, address(this));
        require(usdcAllowance >= _amount, "Not enough USDC allowance");

        uint256 usdcBalance = usdcToken.balanceOf(msg.sender);
        require(usdcBalance >= _amount, "Not enough USDC balance");

        uint256 tokenAmount = _amount / uint256(tokenPrice) * decimalfactor;

        require(token.balanceOf(address(this)) >= tokenAmount, "Insufficient token balance in the contract");

        bool transferSuccess = usdcToken.transferFrom(msg.sender, address(this) , _amount);
        require(transferSuccess, "USDC transfer failed");
        
       
       transferSuccess =  token.transfer(msg.sender, tokenAmount);
       require(transferSuccess, "Coin transfer failed");

        totalTokensSold += tokenAmount;

        emit TokensPurchased(msg.sender, tokenAmount);
    }
 

    function withdrawTokens(uint256 _amount) external onlyOwner {
        require(_amount > 0, "Invalid token amount");

        uint256 tokenBalance = token.balanceOf(address(this));
        require(tokenBalance >= _amount, "Insufficient token balance in the contract");

        bool transferSuccess = token.transfer(owner, _amount);
        require(transferSuccess, "Coin transfer failed");
    }

    function withdrawUSDT(uint256 _amount) external onlyOwner {
        require(_amount > 0, "Invalid USDT amount");

        uint256 usdtBalance = usdtToken.balanceOf(address(this));
        require(usdtBalance >= _amount, "Insufficient USDT balance in the contract");

        bool transferSuccess = usdtToken.transfer(owner, _amount);
        require(transferSuccess, "USDT transfer failed");
    }


    function withdrawUSDC(uint256 _amount) external onlyOwner {
        require(_amount > 0, "Invalid token amount");

        uint256 usdcBalance = usdcToken.balanceOf(address(this));
        require(usdcBalance >= _amount, "Insufficient token balance in the contract");

        bool transferSuccess = usdcToken.transfer(owner, _amount);
        require(transferSuccess, "USDC Coin transfer failed");
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract LandRegistry {
    struct Land{
        uint256 id;
        string location;
        uint256 area;
        address owner;
        bool registered;
    }

    mapping(uint256 => Land) public lands;

    event LandRegistered(uint256 indexed landId,string location,uint256 area,address indexed owner);

    event ownershipTransferred(uint256 indexed landId,address indexed oldOwner,address indexed newOwner);

    function registerLand(uint256 _id,string memory _location,uint256 _area) public{
        require(!lands[_id].registered,"Land already registered");

        lands[_id] = Land({
            id: _id,
            location: _location,
            area: _area,
            owner: msg.sender,
            registered: true
        });

        emit LandRegistered(_id,_location,_area,msg.sender);

    }

    function transferOwnership(uint256 _id,address _newOwner) public {
        Land storage land = lands[_id];
        require(land.registered,"Land not registerd");
        require(land.owner == msg.sender,"Only owner can transfer the ownership");
        require(_newOwner != address(0),"Invalid address");

        address oldOwner = land.owner;
        land.owner = _newOwner;
        
        emit ownershipTransferred(_id,oldOwner,_newOwner);
    }


    function getLand(uint256 _id) public view returns(uint256 id,string memory location,uint256 area,address owner,bool registered){
        Land memory land = lands[_id];
        require(land.registered,"Land not registerd");

        return(land.id,land.location,land.area,land.owner,land.registered);
    }

    
    function isLandRegistered(uint256 _id) public view returns (bool){
        return  lands[_id].registered;
    }



}




//  const contractAddress = "0xB11370E61f8fCD42D679a2cC8d425DdFCd5b9F96"; // Replace with your contract address
//     const abi = [/* Insert ABI Array Here */];

//     let web3, contract, account;

//     window.addEventListener('load', async () => {
//       // Check if Web3 is available
//       if (typeof window.ethereum !== 'undefined') {
//         web3 = new Web3(window.ethereum);
//         try {
//           // Request account access
//           await ethereum.request({ method: 'eth_requestAccounts' });
//           const accounts = await web3.eth.getAccounts();
//           account = accounts[0];
//           console.log("Connected account:", account);

//           contract = new web3.eth.Contract(abi, contractAddress);

//           // Setup event listeners
//           setupEventListeners();
//         } catch (error) {
//           console.error("User denied account access:", error);
//         }
//       } else {
//         alert('Please install MetaMask to use this app.');
//       }
//     });

//     // Setup Event Listeners
//     function setupEventListeners() {
//       // Create Account
//       document.getElementById('createAccount').addEventListener('click', async () => {
//         try {
//           await contract.methods.createAccount().send({ from: account });
//           document.getElementById('createAccountStatus').innerText = "Account created successfully!";
//         } catch (error) {
//           document.getElementById('createAccountStatus').innerText = Error: ${error.message};
//         }
//       });

//       // Deposit Funds
//       document.getElementById('deposit').addEventListener('click', async () => {
//         const amount = document.getElementById('depositAmount').value;
//         try {
//           await contract.methods.deposit().send({ from: account, value: web3.utils.toWei(amount, "ether") });
//           document.getElementById('depositStatus').innerText = "Deposit successful!";
//         } catch (error) {
//           document.getElementById('depositStatus').innerText = Error: ${error.message};
//         }
//       });

//       // Withdraw Funds
//       document.getElementById('withdraw').addEventListener('click', async () => {
//         const amount = document.getElementById('withdrawAmount').value;
//         try {
//           await contract.methods.withdraw(web3.utils.toWei(amount, "ether")).send({ from: account });
//           document.getElementById('withdrawStatus').innerText = "Withdrawal successful!";
//         } catch (error) {
//           document.getElementById('withdrawStatus').innerText = Error: ${error.message};
//         }
//       });

//       // Transfer Funds
//       document.getElementById('transfer').addEventListener('click', async () => {
//         const to = document.getElementById('transferTo').value;
//         const amount = document.getElementById('transferAmount').value;
//         try {
//           await contract.methods.transfer(to, web3.utils.toWei(amount, "ether")).send({ from: account });
//           document.getElementById('transferStatus').innerText = "Transfer successful!";
//         } catch (error) {
//           document.getElementById('transferStatus').innerText = Error: ${error.message};
//         }
//       });

//       // Get Balance
//       document.getElementById('getBalance').addEventListener('click', async () => {
//         try {
//           const balance = await contract.methods.getBalance().call({ from: account });
//           document.getElementById('balance').innerText = Your balance: ${web3.utils.fromWei(balance, "ether")} ETH;
//         } catch (error) {
//           document.getElementById('balance').innerText = Error: ${error.message};
//         }
//       });
//     }
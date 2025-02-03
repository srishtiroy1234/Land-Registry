const contractAddress = "0xB11370E61f8fCD42D679a2cC8d425DdFCd5b9F96"; // Replace with your deployed contract address
const abi = [/* Insert ABI Array Here */]; // Replace with your actual contract ABI

let web3, contract, account;

window.addEventListener("load", async () => {
    if (typeof window.ethereum !== "undefined") {
        web3 = new Web3(window.ethereum);
        try {
            await ethereum.request({ method: "eth_requestAccounts" });
            const accounts = await web3.eth.getAccounts();
            account = accounts[0];
            console.log("Connected account:", account);

            contract = new web3.eth.Contract(abi, contractAddress);

            setupEventListeners();
        } catch (error) {
            console.error("User denied account access:", error);
        }
    } else {
        alert("Please install MetaMask to use this app.");
    }
});

// Setup Event Listeners
function setupEventListeners() {
    // Register Land
    document.getElementById("registerLand").addEventListener("click", async () => {
        const landId = document.getElementById("landId").value;
        const location = document.getElementById("location").value;
        const area = document.getElementById("area").value;

        try {
            await contract.methods.registerLand(landId, location, area).send({ from: account });
            document.getElementById("registerStatus").innerText = "Land registered successfully!";
        } catch (error) {
            document.getElementById("registerStatus").innerText = `Error: ${error.message}`;
        }
    });

    // Transfer Ownership
    document.getElementById("transferOwnership").addEventListener("click", async () => {
        const landId = document.getElementById("transferLandId").value;
        const newOwner = document.getElementById("newOwner").value;

        try {
            await contract.methods.transferOwnership(landId, newOwner).send({ from: account });
            document.getElementById("transferStatus").innerText = "Ownership transferred successfully!";
        } catch (error) {
            document.getElementById("transferStatus").innerText = `Error: ${error.message}`;
        }
    });

    // Get Land Details
    document.getElementById("getLand").addEventListener("click", async () => {
        const landId = document.getElementById("getLandId").value;

        try {
            const land = await contract.methods.getLand(landId).call();
            document.getElementById("landInfo").innerText = 
                `ID: ${land[0]}, Location: ${land[1]}, Area: ${land[2]} sq. ft, Owner: ${land[3]}, Registered: ${land[4]}`;
        } catch (error) {
            document.getElementById("landInfo").innerText = `Error: ${error.message}`;
        }
    });

    // Check If Land is Registered
    document.getElementById("checkRegistration").addEventListener("click", async () => {
        const landId = document.getElementById("checkLandId").value;

        try {
            const isRegistered = await contract.methods.isLandRegistered(landId).call();
            document.getElementById("checkStatus").innerText = isRegistered ? "Land is registered." : "Land is not registered.";
        } catch (error) {
            document.getElementById("checkStatus").innerText = `Error: ${error.message}`;
        }
    });
}

import { network } from "hardhat";

async function main() {
    const { ethers } = await network.connect();

    console.log("Deploying Crowdfunding contract...");

    const crowdfunding = await ethers.deployContract(
        "Crowdfunding",
        [
            "Community Project",
            ethers.parseEther("0.01"),
            7
        ]
    );

    await crowdfunding.waitForDeployment();

    const contractAddress = await crowdfunding.getAddress();

    console.log(
        "Crowdfunding Contract deployed to address:",
        contractAddress
    );
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
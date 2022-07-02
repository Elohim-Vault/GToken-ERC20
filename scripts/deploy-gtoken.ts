import { ethers } from "hardhat";

async function main() {
  const factory = await ethers.getContractFactory("GToken");
  const contract = await factory.deploy(500);
  await contract.deployed();
  console.log("GToken deployed to:", contract.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

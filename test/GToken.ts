import { expect } from "chai";
import { ethers } from "hardhat";
import { GToken } from "../typechain";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";

describe("GToken", function () {
  let contract: GToken;
  const initialSupply = 1000;
  let owner: SignerWithAddress;
  let user1: SignerWithAddress;

  beforeEach(async () => {
    [owner, user1] = await ethers.getSigners();

    const factory = await ethers.getContractFactory("GToken");
    contract = await factory.deploy(initialSupply);
    await contract.deployed();
  });

  it("Contract total supply as deployed", async () => {
    expect(await contract.totalSupply()).to.be.equal(initialSupply);
  });

  it("Owner balance equal to initialSupply", async () => {
    const ownerBalance = await contract.balanceOf(owner.address);
    expect(await contract.totalSupply()).to.be.equal(ownerBalance);
  });

  it("Transfer GToken", async () => {
    expect(await contract.transfer(user1.address, 100)).to.emit(
      contract,
      "Transfer"
    );
  });

  it("Approve and transfer from an user", async () => {
    expect(await contract.connect(owner).approve(user1.address, 1)).to.emit(
      contract,
      "Approval"
    );
    expect(
      await contract.transferFrom(owner.address, user1.address, 1)
    ).to.emit(contract, "Transfer");
  });
});

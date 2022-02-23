const { assert } = require("chai");

const KryptoBird = artifacts.require("./Kryptobird");

require("chai")
  .use(require("chai-as-promised"))
  .should();

contract("KryptoBird", (accounts) => {
  let contract;
  beforeEach(async () => {
    contract = await KryptoBird.deployed();
  });

  describe("Deployement", async () => {
    it("deploys Successfully", async () => {
      assert.notEqual(contract.address, 0x0);
      assert.notEqual(contract.address, "");
      assert.notEqual(contract.address, null);
      assert.notEqual(contract.address, undefined);
    });

    it("has the name", async () => {
      assert.equal(await contract.name(), "Kryptobird");
    });

    it("has the symbol", async () => {
      assert.equal(await contract.symbol(), "KRYPTOZ");
    });

    describe("minting", async () => {
      it("creates a new token", async () => {
        const result = await contract.mint("1");
        const totalSupply = await contract.totalSupply();

        assert.equal(totalSupply, 1);

        const event = result.logs[0].args;

        assert.equal(event._from, "0x0000000000000000000000000000000000000000");
        assert.equal(event._to, accounts[0]);

        await contract.mint("1").should.be.rejected;
      });
    });

    describe("indexing", async () => {
      it("lists kryptoBirdz", async () => {
        await contract.mint("2");
        await contract.mint("3");
        await contract.mint("4");

        const totalSupply = await contract.totalSupply();

        let result = [];
        let kryptoBird;

        for (i = 0; i < totalSupply; i++) {
          kryptoBird = await contract.kryptoBirdz(i);
          result.push(kryptoBird);
        }

        let expected = ["1", "2", "3", "4"];
        assert.equal(result.join(","), expected.join(","));
      });
    });
  });
});

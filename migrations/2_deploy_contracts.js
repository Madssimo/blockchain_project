const EthSwap = artifacts.require("EthSwap");
const Token = artifacts.require("Token");

module.exports = async function(deployer) {
//DEPLOY TOKEN
    await deployer.deploy(Token);
    const token = await Token.deployed()
//DEPLOY ETHSWAP
    await deployer.deploy(EthSwap, token.address);
    const ethSwap = await EthSwap.deployed()

    await token.transfer(ethSwap.address, '1000000000000000000000000')
};

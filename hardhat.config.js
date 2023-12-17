require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */

require("hardhat-tracer");
module.exports = {
  solidity: {
    compilers: [{ version: "0.8.19" }, { version: "0.8.20" }],
  },
  hardhat: "^2.19.2",
};

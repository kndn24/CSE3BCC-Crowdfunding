import { defineConfig, configVariable } from "hardhat/config";
import hardhatEthers from "@nomicfoundation/hardhat-ethers";

export default defineConfig({
  plugins: [hardhatEthers],

  solidity: {
    version: "0.8.34",
  },

  networks: {
    sepolia: {
      type: "http",
      chainType: "l1",

      url: configVariable("SEPOLIA_RPC_URL"),

      accounts: [
        configVariable("SEPOLIA_PRIVATE_KEY"),
      ],
    },
  },
});
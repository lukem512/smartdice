# SMARTDICE

A dice dapp that runs on the Ethereum Virtual Machine. The die will roll a random number between 1 and 6, as determined by [WolframAlpha](https://www.wolframalpha.com) via [Oraclize](http://www.oraclize.it/).

<p align="center"><img src="https://i.imgur.com/JT3BpDz.png" width="500" /></p>

### Usage

To roll, execute the `rollDice` function with enough Ether to cover the Oraclize fee. The result will be made available via the `diceRoll` event and stored in the public `lastRoll` variable as a `uint`. 

### Deployment

Compile using [Remix](https://ethereum.github.io/browser-solidity) and deploy to an Ethereum network of your choice using [Go Ethereum](https://geth.ethereum.org/) or [Parity](https://parity.io).

For instructions on deploying the web application, see [web/README.md](web/README.md).

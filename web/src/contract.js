async function _fetchAbi (path) {
  var abiJson;
  await fetch(path)
  .then(response => response.json())
  .then(json => { abiJson = json });
  return abiJson;
}

async function retrieveContract ({
  abi,
  abiPath,
  address,
}) {
  var contractAbi, contractAddress;

  // Retrieve the ABI
  if (abi) {
    abiJson = abi;
  } else if (abiPath) {
    contractAbi = await _fetchAbi(abiPath)
  } else {
    console.error('Contract ABI was not defined. Please specify an `abi` or an `abiPath`.');
    return;
  }

  // Check the address is valid
  if (web3.isAddress(address)) {
    contractAddress = address;
  } else {
    console.error('Invalid contract address specified');
    return;
  }

  // Retrieve the specified instance of the contract
  var Contract = web3.eth.contract(contractAbi);
  return Contract.at(contractAddress);
}

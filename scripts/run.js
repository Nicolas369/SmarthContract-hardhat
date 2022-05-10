const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners();
    const techStoreContractFactory = await hre.ethers.getContractFactory("TechStore");
    const techStoreContract = await techStoreContractFactory.deploy();
    await techStoreContract.deployed();

    console.log("Contract deployed to: ", techStoreContract.address);
    console.log("Contract deployed by: ", owner.address);
    console.log('=========================================================================================');

    let funds;
    funds = await techStoreContract.seeFunds();

    console.log('');
    console.log('total funds:', funds);

    let buyProductTxn = await techStoreContract.buyProduct(5000000);
    buyProductTxn.wait();

    buyProductTxn = await techStoreContract.connect(randomPerson).buyProduct(5000000);
    await buyProductTxn.wait();

    funds = await techStoreContract.seeFunds();

    console.log('');
    console.log('total funds:', funds);
};


const runMain = async () => {
    try {
      await main();
      process.exit(0); 
    } catch (error) {
      console.error(error);
      process.exit(1); 
    }
};

runMain();
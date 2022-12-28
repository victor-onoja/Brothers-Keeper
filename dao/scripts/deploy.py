from brownie import (
    accounts,
    network,
    BrothersKeeperNFT,
    MarketPlace,
    TablelandTables)

import os

account = accounts.add(os.getenv("BEACON"))
co_founder = "0xC96351bA2E52f81672Dc4f67d94F6D784Ce99d01"
tablelandAddress = '0x4b48841d4b32C4650E4ABc117A03FE8B51f38F68'


def deployGovernor():
    pass


def deployTimelock():
    pass


def deployBrothersKeeperNFT():
    BRK = BrothersKeeperNFT.deploy(
        0.5,
        {'from': account}
        )
    BRK.governorMint(co_founder, {'from': account})
    BRK.governorMint(co_founder, {'from': account})
    BRK.governorMint(co_founder, {'from': account})


def deploytableLand() -> str:
    TT = TablelandTables.deploy({'from': account})
    return TT.address


def deployMarketPlace():
    tableland = tablelandAddress # for polygon mumbai network
    if network.show_active() == 'development':
        tableland = deploytableLand()

    MarketPlace.deploy(
        2,
        'BrothersKeeperMarketPlace',
        tableland,
        {'from': account}
        )

def interactMarketPlace():
    MKP = MarketPlace[0]
    create = MKP.createTable({'from': account})

    lit = MKP.listToken({'from': account})

    lit2 = MKP.listToken({'from': account})

    cancel = MKP.cancelListing({'from': account})

    buy = MKP.buyToken({'from': account})


def main():
    # deployGovernor()
    # deployTimelock()
    deployBrothersKeeperNFT()
    deployMarketPlace()
    interactMarketPlace()


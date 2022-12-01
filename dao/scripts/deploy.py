from brownie import accounts, BrothersKeeperNFT, NFTMarketPlace
import os

account = accounts.load(os.getenv("BEACON"))
blast = "0xC96351bA2E52f81672Dc4f67d94F6D784Ce99d01"


def deployGovernor():
    pass


def deployTimelock():
    pass


def deployBrothersKeeperNFT():
    BRK = BrothersKeeperNFT.deploy(
        0.5,
        {'from': account}
        )
    BRK.governorMint(blast, {'from': account})
    BRK.governorMint(blast, {'from': account})
    BRK.governorMint(blast, {'from': account})


def deployMarketPlace():
    NFTMarketPlace.deploy(
        2,
        'BrothersKeeperMarketPlace',
        '0x4b48841d4b32C4650E4ABc117A03FE8B51f38F68',
        {'from': account}
        )


def main():
    # deployGovernor()
    # deployTimelock()
    deployBrothersKeeperNFT()
    deployMarketPlace()


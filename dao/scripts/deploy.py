from brownie import accounts, BrothersKeeperNFT, NFTMarketPlace
import os

account = accounts.load(os.getenv("BEACON"))

def deployGovernor():
    pass


def deployTimelock():
    pass


def deployBrothersKeeperNFT():
    BrothersKeeperNFT.deploy(
        0.5e18,
        {'from': account}
        )


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


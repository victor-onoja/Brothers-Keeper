import pytest
from brownie import accounts


@pytest.fixture
def deployERC721Token():
    pass


@pytest.fixture
def mintERC721Token():
    pass


@pytest.fixture
def deployERC20Token():
    pass


@pytest.fixture
def deployContract():
    pass


class Test_Tranfers:

    def test_sendCoinOwner(self):
        pass

    def test_sendCoinNotOwner(self):
        pass

    def test_sendERC20TokenOwner(self):
        pass

    def test_sendERC20TokenNotOwner(self):
        pass

    def test_sendERC721TokenOwner(self):
        pass

    def test_sendERC721TokenNotOwner(self):
        pass
    

class Test_Variables:
    
    def test_setTableId(self):
        pass

    def test_setPrefix(self):
        pass


class Test_Listings:
    
    def test_listToken(self):
        pass

    def test_buyToken(self):
        pass

    def test_cancelToken(self):
        pass

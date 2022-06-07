from abc import ABC, abstractmethod
from selenium import webdriver
from selenium.webdriver.support.wait import WebDriverWait

class SignOnPage(ABC):
    @abstractmethod
    def signon(self) -> None:
        """ Method to do the signon """

class SignNowPage(SignOnPage):
    # Some constants
    _URL = "https://signnow.com/s/cpcMwnIO?form=true"
    _LOGO_XPATH = "//div[contains(@class, 'header-logo-container')]//img[@class='logo' and @src='/html/assets/images/sn-logo.svg']"
    _INVITE_EMAIL_ADDRESS_XPATH = "//*[@id='others-role-email-0']"
    _SUBMIT_BTN_XPATH = "//button[@type='submit']"

    def __init__(self, email_address: str) -> None:
        super().__init__()
        self._driver = webdriver.Chrome()
        self._email_address = email_address

    def signon(self):
        self._driver.get(self._URL)
        WebDriverWait(self._driver, 10).until(lambda x: x.find_element_by_xpath(self._LOGO_XPATH))

        self._driver.find_element_by_xpath(self._INVITE_EMAIL_ADDRESS_XPATH).send_keys(self._email_address)
        self._driver.find_element_by_xpath(self._SUBMIT_BTN_XPATH).click()
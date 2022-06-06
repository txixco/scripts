from logging import exception
from selenium import webdriver
import selenium
from selenium.webdriver.support.wait import WebDriverWait
from abc import ABC, abstractmethod, abstractproperty

class PageNotFoundException(Exception):
    pass

class MetlifePage():
    def __init__(self) -> None:
        self.driver = self.openChrome()
        
    def __del__(self) -> None:
        self.driver.close()

    def openChrome(self, url:str = None) -> webdriver:
        if (url is None):
            url = self._URL

        driver = webdriver.Chrome()
        driver.get(url)

        try:
            driver.find_element_by_xpath(self._CHECK_XPATH)
        except selenium.common.exceptions.NoSuchElementException as nsee:
            raise PageNotFoundException("The page has not loaded fine")

        return driver

    @abstractmethod
    def ask():
        pass

class ReimbursementPage(MetlifePage):
    _URL = "https://servicios.metlife.com.mx/wps/portal/seguros/rcfdi"
    _CHECK_XPATH = "//*[@id='reembolsosForm']/h3[1]" 

    def __init__(self) -> None:
        super().__init__()

    def ask(self):
        pass
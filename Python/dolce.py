#!/usr/bin/env python3

from asyncio import exceptions
from genericpath import exists
from lib2to3.pgen2 import driver
from keyring import get_credential
from selenium import webdriver
from selenium.common import exceptions
from selenium.webdriver.common.by import By

# Page information
URL = "dolce-gusto.com.mx"

# Some xpaths
MYACCOUNT_BTN = "//a[contains(@class, 'my-account')]"
MYACCOUNT_LOGGEDOUT = "//a[contains(@class, 'my-account-logged-out')]"
MYACCOUNT_LOGGEDIN = "//a[contains(@class, 'my-account-logged-in')]"

class DolceGustoPage:
    driver: webdriver

    def __init__(self) -> None:
        self.driver = self.openFirefox(URL, MYACCOUNT_BTN)
        
    def __del__(self) -> None:
        self.driver.close()

    def openFirefox(self, url: str, check: str) -> webdriver:
        driver = webdriver.Firefox()
        driver.get(f"https://{url}")

        try:
            driver.find_element(By.XPATH, check)
        except exceptions.NoSuchElementException as nsee:
            print("The page has not loaded fine")

        return driver

    def element_exists(self, xpath: str) -> bool:
        try:
            self.driver.find_element(By.XPATH, xpath)
        except exceptions.NoSuchElementException as nsee:
            return False

        return True

    def is_logged_out(self) -> bool:
        return self.element_exists(MYACCOUNT_LOGGEDOUT)

    def login(self) -> bool:
        if not self.is_logged_out():
            return True

        self.driver.find_element(By.XPATH, MYACCOUNT_LOGGEDOUT).click()
        
        credential = get_credential(URL, None)
        self.driver.find_element(By.ID, "email").send_keys(credential.username)
        self.driver.find_element(By.ID, "pass").send_keys(credential.password)
        self.driver.find_element(By.ID, "send2").click()

        return self.element_exists(MYACCOUNT_LOGGEDIN)

def main():
    dolce = DolceGustoPage()
    if dolce.login():
        print("Logged in")

if __name__ == "__main__":
    main()
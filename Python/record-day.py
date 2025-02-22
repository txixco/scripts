#!/usr/bin/env python3

from keyring import get_password

from selenium import webdriver
from selenium.common import exceptions
from selenium.webdriver.common.by import By
from selenium.webdriver.remote.webelement import WebElement
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


URL = "https://apps.indraweb.net/prelogon.jsp?app=REGJORNA"
SERVICENAME = "indraweb"
USERNAME = "fjruedac"

LOGON_BTN = (By.ID, "nsg-x1-logon-button")
LOGOUT_BTN = (By.CLASS_NAME, "c-indra-header__logout")
REGISTER_BTN = (By.CLASS_NAME, "c-button")

USER_TXT = (By.ID, "login")
PASSWD_TXT = (By.ID, "passwd")

class DayRegisterPage:
	driver: webdriver

	def __init__(self) -> None:
		self.open(URL, LOGON_BTN)
		
	def __del__(self) -> None:
		self.driver.close()

	def open(self, url: str, check: tuple[By, str]) -> None:
		self.driver = webdriver.Edge()
		self.driver.get(url)

		self.wait_for_element(check)

	def wait_for_element(self, element: tuple[By, str]) -> bool:
		wait: WebDriverWait = WebDriverWait(self.driver, 10)
		found: WebElement = wait.until(EC.visibility_of_element_located(element))

		return True

	def element_exists(self, element: tuple[By, str]) -> bool:
		try:
			self.driver.find_element(element)
		except exceptions.NoSuchElementException:
			return False

		return True

	def find_element(self, element: tuple[By, str]) -> WebElement:
		(by, value) = element
		return self.driver.find_element(by, value)

	def is_logged_in(self) -> bool:
		return self.wait_for_element(LOGOUT_BTN)

	def is_logged_out(self) -> bool:
		return self.wait_for_element(LOGON_BTN)

	def is_end_day(self) -> bool:
		self.wait_for_element(REGISTER_BTN)

		return self.find_element(REGISTER_BTN).text == "Finalizar jornada"

	def login(self) -> bool:
		if not self.is_logged_out():
			return True
		
		self.find_element(USER_TXT).send_keys(USERNAME)
		self.find_element(PASSWD_TXT).send_keys(
			get_password(SERVICENAME, USERNAME))
		self.find_element(LOGON_BTN).click()

		return self.is_logged_in

	def begin_day(self) -> None:
		pass

	def finish_day(self) -> None:
		self.find_element(REGISTER_BTN).click()

def main():
	register = DayRegisterPage()
	if not register.login():
		raise("Not logged in")
	
	if register.is_end_day():
		register.finish_day()
	else:
		register.begin_day()

if __name__ == "__main__":
	main()

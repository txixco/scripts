from os import getenv

from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.edge.options import Options
from selenium.webdriver.support import expected_conditions as EC

class Nescafe:
    """Clase para interactuar con la página de Nescafé España."""

    URL = "https://www.nescafe.es/sueldo"
    PROFILE_BUTTON_ID = "dropdownMenuButton"
    CLOSE_MODAL_CLASS = "close-code-modal"

    driver: webdriver.Edge
    username: str

    def __init__(self, username: str):
        edge_options = Options()
        self.driver = webdriver.Edge()
        self.login(username)

    def accept_cookies(self):
        """Acepta las cookies en la página de Nescafé."""

        try:
            self.driver.find_element(By.ID, "onetrust-accept-btn-handler").click()
        except Exception as e:
            print(f"Error al aceptar cookies: {e}")

    def close_modal(self):
        """Cierra el popup si está presente."""

        try:
            close_button = self.driver.find_element(By.CLASS_NAME, self.CLOSE_MODAL_CLASS)
            close_button.click()
        except Exception as e:
            print(f"Error al cerrar el popup: {e}")

    def is_logged_in(self) -> bool:
        try:
            self.driver.find_element(By.ID, "dropdownMenuButton")
            return True
        except:
            return False

    def login(self, username: str):
        if self.is_logged_in():
            return

        self.driver.implicitly_wait(2)
        self.driver.get(self.URL + "/login")

        self.accept_cookies()

        user_field = self.driver.find_element(By.NAME, "username")
        pass_field = self.driver.find_element(By.NAME, "password")

        webdriver.ActionChains(self.driver).move_to_element(user_field).perform()
        user_field.send_keys(getenv("USERNAME"))
        pass_field.send_keys(getenv("PASSWORD"))

        pass_field.send_keys(Keys.RETURN)

        self.username = username

    def logout(self):
        if not self.is_logged_in():
            return

        self.driver.find_element(By.ID, self.PROFILE_BUTTON_ID).click()
        logout_button = self.driver.find_element(By.CLASS_NAME, "trackGTM_UserAccountLogoutButton")
        logout_button.click()
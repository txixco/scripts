from selenium import webdriver
from selenium.webdriver.common.keys import Keys

class AlexaPage:
    """ Implements different methods to manage the Alexa webpage """

    def __init__(self) -> None:
        self.driver = self.openChrome("https://alexa.amazon.com.mx")
        self.doLogin()
    
    def __enter__(self) -> None:
        pass
    
    def __exit__(self, type, value, tb) -> None:
        self.driver.close()

    def doLogin(self) -> None:
        """ Do the login """

        self.driver.find_element_by_id("ap_email").send_keys("frueda@protonmail.com")
        self.driver.find_element_by_id("ap_password").send_keys("MZN101cm")
        self.driver.find_element_by_id("signInSubmit").click()

        otp = input("Introduzca el código OTP: ")
        self.driver.find_element_by_id("auth-mfa-otpcode").send_keys(otp)
        self.driver.find_element_by_id("auth-signin-button").click()
        
    def openChrome(self, url: str) -> webdriver:
        """ Open Chrome in the given url """

        driver = webdriver.Chrome()
        driver.get(url)

        return driver

def main():
    """ Do the main stuff """

    with AlexaPage() as webpage:

        elems = driver.find_elements_by_class_name("d-card-menu")
        for elem in elems :
            print(elem.get_attribute("innerhtml"))

if __name__ == "__main__":
    main()
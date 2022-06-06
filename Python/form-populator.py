from random import randrange, choice
from secrets import choice
from selenium import webdriver
from selenium.webdriver.common.by import By

from logging import exception
from abc import ABC, abstractmethod, abstractproperty

"""Script to populate a form"""

_URL = "https://docs.google.com/forms/d/e/1FAIpQLScXUGXbqUp0e8t1FEe3fX1OLjLkVlc-Q0h0hwyRpEUKHagXgA/viewform"
_PLATFORMS = [ "Streaming", "TV", "Blu-ray" ]
_STREAMS = [ "Netflix", "Netflix", "Disney+", "Disney+", "HBO Max", "YouTube" ]
_PHRASES_GOOD = [ "Me siento más cómodo usándolo", "Me gusta más la oferta", "Está más chido", "Mola más", "Es lo que usa mi familia", "Lo usan mis colegas" ]
_PRASHES_BAD = [ "No me gusta", "Siento que es incómodo de usar", "No está padre",  "No mola nada", "No lo usa nadie en mi ambiente", "Mis colegas no lo usan" ] 

def openBrowser() -> webdriver:
    """Function to open the browser in the corret URL"""

    profile = webdriver.FirefoxProfile()
    profile.set_preference("browser.privatebrowsing.autostart", True)

    driver = webdriver.Firefox(firefox_profile=profile)
    driver.get(_URL)

    return driver

def setText(browser: webdriver, question: str, text: str) -> None:
    """Set value for a text element"""

    element = browser.find_element(by=By.XPATH, 
                                   value=f"//div[text()='{question}']/ancestor::div[@class='geS5n']//textarea")
    element.clear()
    element.click()
    element.send_keys(text)

def selectOption(browser: webdriver, xpath: str, option: int) -> None:
    """Select an option from radio buttons"""

    elements = browser.find_elements(by=By.XPATH, value=xpath)
    elements[option].click()

def main():
    """Main function"""

    browser = openBrowser()
    
    setText(browser=browser, question="¿Cuántos años tienes?", text=randrange(12, 80))

    option = randrange(0, 3)
    print(option)
    selectOption(browser=browser,
                 xpath="//div//div[text()='¿En que medio ves películas/series más comúnmente?']/ancestor::div[@class='geS5n']//div[@role='radio']",
                 option=option)

    setText(browser=browser, 
            question="¿Cuál de los medios anteriores crees que es mejor?", 
            text=_PLATFORMS[option])

    setText(browser=browser,
            question="¿Por qué?",
            text=choice(_PHRASES_GOOD))

if __name__ == "__main__":
    main()
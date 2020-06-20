from selenium import webdriver
from selenium.webdriver.common.keys import Keys

def doLogin(driver) :
    driver.find_element_by_id("ap_email").send_keys("txixco@gmail.com")
    driver.find_element_by_id("ap_password").send_keys("MZN101cm")
    
driver = webdriver.Chrome()
driver.get("https://alexa.amazon.com.mx/spa/index.html#cards")

elems = driver.find_elements_by_class_name("d-card-menu")
for elem in elems :
    print(elem.get_attribute("innerhtml"))

driver.close()

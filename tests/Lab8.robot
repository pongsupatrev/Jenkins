*** Keywords ***
Open Browser To Computing Page
    ${options}=    Evaluate
    ...    (lambda: (lambda o: (o.add_argument("--no-sandbox"),
    ...                         o.add_argument("--disable-dev-shm-usage"),
    ...                         o.add_argument("--headless=new"),
    ...                         o.add_argument("--disable-gpu"),
    ...                         o)[-1])(selenium.webdriver.ChromeOptions()))()
    ...    modules=selenium

    ${service}=    Evaluate    selenium.webdriver.chrome.service.Service("/usr/bin/chromedriver")    modules=selenium
    Create Webdriver    Chrome    options=${options}    service=${service}
    Go To    ${URL}
    Wait Until Page Contains Element    xpath=//body    timeout=10s

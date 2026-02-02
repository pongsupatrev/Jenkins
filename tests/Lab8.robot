*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}      https://computing.kku.ac.th

*** Test Cases ***
Open KKU Computing Website
    Open Browser To Computing Page
    Page Should Contain Element    xpath=//body
    [Teardown]    Close Browser

Check Page Title Is Not Empty
    Open Browser To Computing Page
    ${title}=    Get Title
    Should Not Be Empty    ${title}
    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Computing Page
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    Call Method    ${chrome_options}    add_argument    --headless

    ${service}=    Evaluate    sys.modules['selenium.webdriver.chrome.service'].Service("/usr/bin/chromedriver")    sys
    Create Webdriver    Chrome    options=${chrome_options}    service=${service}

    Go To    ${URL}
    Wait Until Page Contains Element    xpath=//body    timeout=10s


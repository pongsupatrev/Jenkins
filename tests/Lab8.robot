*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}          https://computing.kku.ac.th
${BROWSER}      chromium
${CHROME_BIN}   /usr/bin/chromium
${DRIVER}       /usr/bin/chromedriver

*** Test Cases ***
Test Open KKU Computing Website
    Open Browser To Computing Page
    Page Should Contain Element    xpath=//body
    Close Browser

Test Page Title
    Open Browser To Computing Page
    ${title}=    Get Title
    Should Not Be Empty    ${title}
    Log    Page Title: ${title}
    Close Browser

Test Page Load Successfully
    Open Browser To Computing Page
    ${url}=    Get Location
    Should Contain    ${url}    computing.kku.ac.th
    Close Browser

*** Keywords ***
Open Browser To Computing Page
    ${options}=    Evaluate    ChromeOptions()    modules=selenium.webdriver
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --headless=new
    Call Method    ${options}    add_argument    --disable-gpu

    ${service}=    Evaluate    Service("/usr/bin/chromedriver")    modules=selenium.webdriver.chrome.service
    Create Webdriver    Chrome    options=${options}    service=${service}

    Go To    ${URL}
    Wait Until Page Contains Element    xpath=//body    timeout=10s


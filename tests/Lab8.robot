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
    ${opts}=    Create List
    ...    --headless=new
    ...    --no-sandbox
    ...    --disable-dev-shm-usage
    ...    --disable-gpu

    Create Webdriver
    ...    Chrome
    ...    executable_path=${DRIVER}
    ...    options=add_argument=${opts}
    ...    binary_location=${CHROME_BIN}

    Go To    ${URL}
    Wait Until Page Contains Element    xpath=//body    timeout=20s

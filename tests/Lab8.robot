*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://computing.kku.ac.th
${BROWSER}    headlesschrome

*** Test Cases ***
Test Open KKU Computing Website
    [Documentation]    ทดสอบการเปิดเว็บไซต์คณะคอมพิวเตอร์ มข.
    [Tags]    smoke    web
    Open Browser To Computing Page
    Page Should Contain Element    xpath=//body
    Close Browser

Test Page Title
    [Documentation]    ทดสอบว่าหน้าเว็บมี title ถูกต้อง
    [Tags]    web
    Open Browser To Computing Page
    ${title}=    Get Title
    Should Not Be Empty    ${title}
    Log    Page Title: ${title}
    Close Browser

Test Page Load Successfully
    [Documentation]    ทดสอบว่าหน้าเว็บโหลดสำเร็จ
    [Tags]    smoke
    Open Browser To Computing Page
    ${url}=    Get Location
    Should Contain    ${url}    computing.kku.ac.th
    Close Browser

*** Keywords ***
Open Browser To Computing Page
    [Documentation]    เปิดเบราว์เซอร์ไปที่เว็บไซต์คณะคอมพิวเตอร์
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    
    Create Webdriver    Chrome    options=${chrome_options}
    Go To    ${URL}
    Wait Until Page Contains Element    xpath=//body    timeout=10s
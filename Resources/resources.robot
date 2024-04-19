*** Settings ***
Library           SeleniumLibrary
Library           BuiltIn
Library           Collections
Library           String
Library           DateTime

*** Variables ***
${URL}            https://katalon-demo-cura.herokuapp.com/
${BROWSER}        chrome

*** Keywords ***
Open Browser To Katalon Demo CURA
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Verify the URL
    [Arguments]    ${URL}
    ${current_url} =    Get Location
    Should Be Equal As Strings    ${current_url}    ${URL}    

Open Browser and login
    Open Browser To Katalon Demo CURA
    Click Element    xpath://*[@id="menu-toggle"]
    Sleep    2
    Click Element    xpath://*[@id="sidebar-wrapper"]/ul/li[3]/a
    Wait Until Element Is Visible    xpath://*[@id="login"]/div/div/div[2]/form/div[1]
    Input Text    id=txt-username    John Doe
    Input Text    id=txt-password    ThisIsNotAPassword
    Click Button    id=btn-login

Verify information of booking
    [Arguments]    ${facility}    ${checkbox}    ${program}    ${date}    ${comment}
    ${actual_facility}    Get Text    id=facility
    Should Be Equal    ${actual_facility}    ${facility}
    ${actual_checkbox}    Get Text    id=hospital_readmission
    Should Be Equal    ${actual_checkbox}    ${checkbox}
    ${actual_program}    Get Text    id=program
    Should Be Equal    ${actual_program}    ${program}
    ${actual_date}    Get Text    id=visit_date
    Should Be Equal    ${actual_date}    ${date}
    ${actual_comment}    Get Text    id=comment
    Should Be Equal    ${actual_comment}    ${comment}

Verify Placeholders
    [Arguments]    ${expected_placeholder}    ${element}
    ${webelement}=  Get WebElement  ${element}
    ${placeholder}=  Call Method  ${webelement}  get_attribute  placeholder
    Should Be Equal As Strings  ${placeholder}  ${expected_placeholder}




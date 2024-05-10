*** Settings ***
Library           SeleniumLibrary
Library           BuiltIn
Library           Collections
Library           String
Library           DateTime
Library           SSHLibrary
Library           OperatingSystem
Library           RequestsLibrary

*** Variables ***
${URL}            https://katalon-demo-cura.herokuapp.com/
${BROWSER}        chrome
${SESSION_ID}     ${EMPTY}

*** Keywords ***

    # **********************************************************************************************************************
    # For the demo Booking and History

Open Browser To Katalon Demo CURA
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Open Browser and login
    Open Browser To Katalon Demo CURA
    Click Element    xpath://*[@id="menu-toggle"]
    Sleep    2
    Click Element    xpath://*[@id="sidebar-wrapper"]/ul/li[3]/a
    Wait Until Element Is Visible    xpath://*[@id="login"]/div/div/div[2]/form/div[1]
    Input Text    id=txt-username    John Doe
    Input Text    id=txt-password    ThisIsNotAPassword
    Click Button    id=btn-login
    ${SESSION_ID}=    Get Session Id

Book appointment demo
    [Arguments]    ${facility}    ${program}    ${date}    ${comment}
    Select From List By Value    xpath://*[@id="combo_facility"]    ${facility}
    Select Checkbox    xpath://*[@id="chk_hospotal_readmission"]
    ${checkbox_status}=    Run Keyword And Return Status    Checkbox Should Be Selected    id:chk_hospotal_readmission
    ${checkbox}=    Set Variable If    ${checkbox_status}    Yes
    ...    ELSE    No
    Select Radio Button    programs    ${program}
    Input Text    id:txt_visit_date    ${date}
    Input Text    id=txt_comment    ${comment}
    Click Button    id=btn-book-appointment

Go to History
    Click Element    xpath://*[@id="menu-toggle"]
    Sleep    2
    Click Element    xpath://*[@id="sidebar-wrapper"]/ul/li[3]/a

Verify Last Panel Info
    [Arguments]    ${facility}    ${checkbox}    ${program}    ${date}    ${comment}
    ${panel_count}=    Get Element Count    xpath=//div[contains(@class, 'panel panel-info')]
    Log    Panel Count: ${panel_count}
    ${last_panel_xpath}=    Set Variable    (//div[contains(@class, 'panel panel-info')])[last()]
    Log    Last Panel XPath: ${last_panel_xpath}
    Wait Until Element Is Visible    ${last_panel_xpath}    timeout=10s
    ${last_panel}=    Get WebElements    ${last_panel_xpath}
    Log    Last Panel Elements: ${last_panel}
    ${panel_info}=    Set Variable    ${EMPTY}
    Run Keyword If    '${last_panel}' != '${EMPTY}'    Get Panel Info    ${last_panel} ${facility}    ${checkbox}    ${program}    ${date}    ${comment}
    ...    ELSE    Log    Last panel element not found

Get Panel Info
    [Arguments]    ${last_panel}    ${facility}    ${checkbox}    ${program}    ${date}    ${comment}
    ${panel_info}=    Get Text    ${last_panel}[0]
    Log    Last Panel Info: ${panel_info}
    ${panel_list}=    Split String    ${panel_info}    \n
    Run Keyword If    '${date}' == '${EMPTY}'    Insert Into List    ${panel_list}    0    ${EMPTY}
    Run Keyword If    '${comment}' == '${EMPTY}'    Insert Into List    ${panel_list}    8    ${EMPTY}
    Log    Panel List: ${panel_list}
    Should Be Equal As Strings    ${facility}    ${panel_list}[2]
    Should Be Equal As Strings    ${checkbox}    ${panel_list}[4]
    Should Be Equal As Strings    ${program}    ${panel_list}[6]
    Should Be Equal As Strings    ${comment}    ${panel_list}[8]
    Should Be Equal As Strings    ${date}    ${panel_list}[0]

Verify the URL
    [Arguments]    ${URL}
    ${current_url} =    Get Location
    Should Be Equal As Strings    ${current_url}    ${URL}

Check Session And Login If Needed

${current_session_id}=
    Get Session Id
    IF    '${current_session_id}' == 'None'
        Open Browser and login
    ELSE
        Go To    https://katalon-demo-cura.herokuapp.com/
    END

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
    ${webelement}=    Get WebElement    ${element}
    ${placeholder}=    Call Method    ${webelement}    get_attribute    placeholder
    Should Be Equal As Strings    ${placeholder}    ${expected_placeholder}

Scroll Down Slowly
    [Arguments]    ${scroll_speed}=0.5    ${scroll_step}=100
    ${scroll_position}=    Execute JavaScript    return window.pageYOffset;
    ${page_height}=    Execute JavaScript    return document.body.scrollHeight;
    ${scroll_target}=    Evaluate    ${page_height} * 0.5
    FOR    ${i}    IN RANGE    ${scroll_position}    ${scroll_target}    ${scroll_step}
        Execute JavaScript    window.scrollTo(0, ${i});
        Sleep    ${scroll_speed}
    END

Get List Of Dates
    @{dates_elements}=    Get WebElements    class:panel-heading
    Log To Console    ${dates_elements}
    ${dates_text}=    Create List
    FOR    ${element}    IN    @{dates_elements}
        ${date}=    Get Text    ${element}
        Append To List    ${dates_text}    ${date}
    END
    # **********************************************************************************************************************
    # For the demo Authentication
    [Return]    ${dates_text}

Invalid account
    Verify the URL    https://katalon-demo-cura.herokuapp.com/profile.php#login
    Element Should Be Visible    xpath://*[@id="login"]/div/div/div[1]/p[2]
    Element Text Should Be    xpath://*[@id="login"]/div/div/div[1]/p[2]    Login failed! Please ensure the username and password are valid.

Open Browser And Go To Login
    Open Browser To Katalon Demo CURA
    Click Element    xpath://*[@id="menu-toggle"]
    Sleep    2
    Click Element    xpath://*[@id="sidebar-wrapper"]/ul/li[3]/a
    Wait Until Element Is Visible    xpath://*[@id="login"]/div/div/div[2]/form/div[1]

Input Username and Password
    [Arguments]    ${Username}    ${Password}
    Input Text    id:txt-username    ${Username}
    Sleep    1
    Input Text    id:txt-password    ${Password}
    Sleep    1
    Click Button    id:btn-login

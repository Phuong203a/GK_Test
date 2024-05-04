*** Settings ***
Resource          ../../Resources/resources.robot

*** Test Cases ***
Testcase 01
    [Documentation]    Verify the first time accessing and no login yet
    Open Browser To Katalon Demo CURA
    Click Element    xpath://*[@id="menu-toggle"]
    ${list_items}=    Get WebElements    xpath://ul[@class='sidebar-nav']/li
    Log To Console    message: ${list_items}
    ${lst}=    Create List    ${EMPTY}
    FOR    ${item}    IN    @{list_items}
        ${item_text}=    Get Text    ${item}
        Append To List    ${lst}    ${item_text}
    END
    Log To Console    message: ${lst}
    List Should Not Contain Value    ${lst}    Profile
    Sleep    5
    Close Browser

Testcase 02
    [Documentation]    Input the url to the profile page without login
    Open Browser To Katalon Demo CURA
    Go To    https://katalon-demo-cura.herokuapp.com/profile.php#profile
    Sleep    5
    Page Should Contain    Login
    Page Should Contain    Please login to make appointment.

Testcase 03
    [Documentation]    Go to the profile page after login
    Open Browser and login
    Sleep    5
    Click Element    xpath://*[@id="menu-toggle"]
    Click Element    xpath://*[@id="sidebar-wrapper"]/ul/li[4]/a
    Wait Until Element Is Visible    xpath://*[@id="profile"]/div/div/div/h2
    Page Should Contain    Under construction.
    Page Should Contain Link    xpath://*[@id="profile"]/div/div/div/p[2]/a



    
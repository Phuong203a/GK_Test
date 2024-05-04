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
    List Should Not Contain Value    ${lst}    History
    Sleep    5
    Close Browser

Testcase 02
    [Documentation]    No History for booking
    Open Browser and login
    Click Element    xpath://*[@id="menu-toggle"]
    Sleep    3
    Click Element    xpath://*[@id="sidebar-wrapper"]/ul/li[3]/a
    Sleep    3
    Page Should Contain    No appointment.
    Verify the URL    https://katalon-demo-cura.herokuapp.com/history.php#history
    Sleep    2
    # Close Browser

Testcase 03
    [Documentation]    Verify the order date of history after booking
    Open Browser and login
    @{booking_dates}=    Create List    25/05/2024    22/05/2024    26/05/2024
    FOR    ${date}    IN    @{booking_dates}
        Book appointment demo    Tokyo CURA Healthcare Center    Medicaid    ${date}    This is Comment
        Sleep    1
        Wait Until Element Is Visible    xpath://*[@id="summary"]/div/div/div[7]/p/a
        Click Element    xpath://*[@id="summary"]/div/div/div[7]/p/a
    END
    Go to History
    Sleep    2
    Scroll Down Slowly
    @{history_dates}=    Get List Of Dates
    Log To Console    message: ${history_dates}
    Log To Console    message: ${booking_dates}
    Lists Should Be Equal    ${booking_dates}    ${history_dates}

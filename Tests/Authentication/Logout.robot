*** Settings ***
Resource          ../../Resources/resources.robot

*** Test Cases ***
TC1:
    [Documentation]    Log Out from Home page after login
    Open Browser and login
    Click Element    id:menu-toggle
    Sleep    1
    Click Element    xpath://*[@id="sidebar-wrapper"]/ul/li[5]/a
    Location Should Be    https://katalon-demo-cura.herokuapp.com/
    Close Browser

TC2:
    [Documentation]    Log Out by go back on browser
    Open Browser and login
    Sleep    2
    Go Back
    Sleep    2
    Location Should Be    https://katalon-demo-cura.herokuapp.com/profile.php#login
    Go Back
    Sleep    2
    Location Should Be    https://katalon-demo-cura.herokuapp.com/
    Click Element    id:menu-toggle
    Sleep    1
    Click Element    xpath://*[@id="sidebar-wrapper"]/ul/li[3]/a
    Sleep    1
    Element Should Be Visible    id:profile
    Click Element    xpath://*[@id="profile"]/div/div/div/p[2]/a
    Location Should Be    https://katalon-demo-cura.herokuapp.com/
    Close Browser

TC3:
    [Documentation]    Log out by Profile page
    Open Browser and login
    Sleep    1
    Click Element    id:menu-toggle
    Sleep    1
    Click Element    xpath://*[@id="sidebar-wrapper"]/ul/li[4]/a
    Sleep    1
    Location Should Be    https://katalon-demo-cura.herokuapp.com/profile.php#profile
    Click Element    xpath://*[@id="profile"]/div/div/div/p[2]/a
    Location Should Be    https://katalon-demo-cura.herokuapp.com/
    Close Browser

TC4:
    [Documentation]    Check after log out and Go Back we will go to login page
    Open Browser and login
    Click Element    id:menu-toggle
    Sleep    1
    Click Element    xpath://*[@id="sidebar-wrapper"]/ul/li[5]/a
    Location Should Be    https://katalon-demo-cura.herokuapp.com/
    Go Back
    Sleep    1
    Go Back
    Sleep    1
    Location Should Be    https://katalon-demo-cura.herokuapp.com/profile.php#login
    ${Username}=    Get Value    id=txt-username
    ${Password}=    Get Value    id=txt-password
    Should Be Equal    ${Username}    John Doe
    Should Be Equal    ${Password}    ThisIsNotAPassword
    Close Browser

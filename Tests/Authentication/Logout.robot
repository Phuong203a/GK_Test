*** Settings ***
Resource          ../../Resources/resources.robot

*** Test Cases ***
TC1:
    [Documentation]    Log Out from Home page after login
    Open Browser and login
    Click Element    id:menu-toggle
    Sleep    2s
    Click Element    xpath://*[@id="sidebar-wrapper"]/ul/li[5]/a
    Location Should Be    https://katalon-demo-cura.herokuapp.com/
    Sleep    2s
    Click Element    xpath://*[@id="btn-make-appointment"]
    Location Should Be    https://katalon-demo-cura.herokuapp.com/profile.php#login
    Close Browser

TC2:
    [Documentation]    Log out by Profile page
    Open Browser and login
    Sleep    2s
    Click Element    id:menu-toggle
    Sleep    2s
    Click Element    xpath://*[@id="sidebar-wrapper"]/ul/li[4]/a
    Sleep    2s
    Location Should Be    https://katalon-demo-cura.herokuapp.com/profile.php#profile
    Click Element    xpath://*[@id="profile"]/div/div/div/p[2]/a
    Location Should Be    https://katalon-demo-cura.herokuapp.com/
    Sleep    2s
    Click Element    xpath://*[@id="btn-make-appointment"]
    Location Should Be    https://katalon-demo-cura.herokuapp.com/profile.php#login
    Close Browser

TC3:
    [Documentation]    Verify that the logout process prevents HTTP session hijacking.
    Open Browser and Login
    Click Element    id:menu-toggle
    Sleep    2s
    Click Element    xpath://*[@id="sidebar-wrapper"]/ul/li[5]/a
    Sleep    2s
    Location Should Be    https://katalon-demo-cura.herokuapp.com/
    ${response}    Get    https://katalon-demo-cura.herokuapp.com/history.php#history    401
    Close Browser

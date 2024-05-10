*** Settings ***
Resource          ../../Resources/resources.robot

*** Test Cases ***
TC1:
    [Documentation]    Verify at fist access
    Open Browser And Go To Login
    ${Username}=    Get Value    xpath://*[@id="login"]/div/div/div[2]/form/div[1]/div[1]/div/div/input
    Should Be Equal    ${Username}    John Doe
    ${Password}=    Get Value    xpath://*[@id="login"]/div/div/div[2]/form/div[1]/div[2]/div/div/input
    Should Be Equal    ${Password}    ThisIsNotAPassword
    ${TrueUsername}=    Get Value    id:txt-username
    ${TruePassword}=    Get Value    id:txt-password
    Should Be Empty    ${TrueUsername}
    Should Be Empty    ${TruePassword}
    Verify Placeholders    Username    id:txt-username
    Verify Placeholders    Password    id:txt-password
    Close Browser

TC2:
    [Documentation]    Case wrong username
    Open Browser And Go To Login
    Input Text    id:txt-username    Khanh Huan
    Sleep    1
    Input Text    id:txt-password    ThisIsNotAPassword
    Sleep    1
    Click Element    id:btn-login
    Invalid account
    Close Browser

TC3:
    [Documentation]    Case wrong password
    Open Browser And Go To Login
    Input Text    id:txt-username    John Doe
    Sleep    1
    Input Text    id:txt-password    huan123
    Sleep    1
    Click Element    id:btn-login
    Invalid account
    Close Browser

TC4:
    [Documentation]    Case input username is empty
    Open Browser And Go To Login
    ${Username}=    Get Value    id:txt-username
    Should Be Empty    ${Username}
    Input Text    id:txt-password    ThisIsNotAPassword
    Sleep    1
    Click Element    id:btn-login
    Invalid account
    Close Browser

TC5:
    [Documentation]    Case input password empty
    Open Browser And Go To Login
    Input Text    id:txt-username    John Doe
    Sleep    1
    ${Password}=    Get Value    id:txt-password
    Should Be Empty    ${Password}
    Click Element    id:btn-login
    Invalid account
    Close Browser

TC6:
    [Documentation]    Using email instead of name
    Open Browser And Go To Login
    Input Username and Password    johndoe@gmail.com    ThisIsNotAPassword
    Invalid account
    Input Username and Password    JohnDoe@gmail.com    ThisIsNotAPassword
    Invalid account
    Input Username and Password    Johndoe@gmail.com    ThisIsNotApassword
    Invalid account
    Close Browser

TC7:
    [Documentation]    Using excessive length usernames and passwords
    Open Browser And Go To Login
    Input Username and Password    jalsdjasldjsaljdsalkjdlsajdlkajsldjalsjdlakdjlasjdlaskjdlaskdjalksjdaljdlkasjdalkjdlaskjdlasjdlkasjdlaskjdlsadj    ajskldjasldjlsajdsalkdjsaljdlaskjdlasjdlksajdlkasjdlksajdlksajdlksajdlkasjdlkasjdlkasjdlksajdlaskjdaslkjdlakjdlas
    Invalid account
    Close Browser

TC8:
    [Documentation]    Case UPPERCASE Username
    Open Browser And Go To Login
    Input Username and Password    JOHN DOE    ThisIsNotAPassword
    Invalid account
    Close Browser

TC9:
    [Documentation]    Check Password in type password
    Open Browser And Go To Login
    Input Text    id:txt-username    John Doe
    Input Text    id:txt-password    ThisIsNotApassword
    Sleep    1
    Element Attribute Value Should Be    id=txt-password    type    password
    Close Browser

TC10:
    [Documentation]    Login Successful with correct username and password
    Open Browser And Go To Login
    Input Username and Password    John Doe    ThisIsNotAPassword
    Location Should Be    https://katalon-demo-cura.herokuapp.com/#appointment
    Close Browser

TC11:
    [Documentation]    Case press Tab to move to password input and press Enter to login instead of Login button
    Open Browser And Go To Login
    Input Text    id:txt-username    John Doe
    Press Keys    id:txt-username    TAB
    Input Text    id:txt-password    ThisIsNotAPassword
    Press Keys    id:txt-password    RETURN
    Location Should Be    https://katalon-demo-cura.herokuapp.com/#appointment
    Close Browser

TC12:
    [Documentation]    Move to login form by button Make Appointment on Main page
    Open Browser To Katalon Demo CURA
    Element Should Not Be Visible    id:login
    Click Element    id:btn-make-appointment
    Sleep    1
    Location Should Be    https://katalon-demo-cura.herokuapp.com/profile.php#login
    Element Should Be Visible    id:login
    Close Browser

TC13:
    [Documentation]    User cancel Login process and return main form
    Open Browser To Katalon Demo CURA
    Element Should Not Be Visible    id:login
    Click Element    id:btn-make-appointment
    Sleep    1
    Location Should Be    https://katalon-demo-cura.herokuapp.com/profile.php#login
    Input Text    id:txt-username    John Doe
    Sleep    1
    Go Back
    Sleep    1
    Location Should Be    https://katalon-demo-cura.herokuapp.com/
    Element Should Not Be Visible    id:login
    Close Browser

TC14:
    [Documentation]    Case User attempt SQL injection in username field
    Open Browser And Go To Login
    Input Username and Password    John Doe' --    ThisIsNotAPassword
    Invalid account
    Close Browser

TC15
    [Documentation]    Case User attempt SQL injection in password feild
    Open Browser And Go To Login
    Input Username and Password    John Doe    ThisIsNotAPassword' --
    Invalid account
    Close Browser

TC16
    [Documentation]    Case User attemp XSS attack in username field
    Open Browser And Go To Login
    Input Username and Password    <script>alert('XSS attack detected');</script>    ThisIsNotAPassword
    Alert Should Not Be Present
    Invalid account
    Close Browser

TC17:
    [Documentation]    Case User attemp XSS attack in password field
    Open Browser And Go To Login
    Input Username and Password    John Doe    <script>alert('XSS attack detected');</script>
    Alert Should Not Be Present
    Invalid account
    Close Browser

TC18:
    [Documentation]    Check Login page using HTTPS to transmission data
    Open Browser And Go To Login
    Location Should Be    https://katalon-demo-cura.herokuapp.com/profile.php#login
    Should Contain    https://katalon-demo-cura.herokuapp.com/profile.php#login    https://
    ${encrypted_request}=    Execute Javascript
    ...    return window.location.protocol === 'https:'
    Should Be True    ${encrypted_request}
    Close Browser

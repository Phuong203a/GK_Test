*** Settings ***
Resource          ../../Resources/resources.robot

*** Test Cases ***
TC1:
    [Documentation]    Turn on menu
    Open Browser To Katalon Demo CURA
    Sleep    2s
    Click Element    xpath://*[@id="menu-toggle"]
    Element attribute value should be    xpath=//*[@id="sidebar-wrapper"]    class    active
    Close Browser

TC2:
    [Documentation]    Turn off menu
    Open Browser To Katalon Demo CURA
    Sleep    2s
    Click Element    xpath://*[@id="menu-toggle"]
    Sleep    2s
    Element attribute value should be    xpath=//*[@id="sidebar-wrapper"]    class    active
    Click Element    xpath://*[@id="menu-toggle"]
    Sleep    2s
    ${Element}    Get WebElement    xpath=//*[@id="sidebar-wrapper"]
    ${ClassAttr}    Get Element Attribute    ${Element}    class
    Should be empty    ${ClassAttr}
    Close Browser

TC3:
    [Documentation]    Scroll until the scroll item appear not login
    Open Browser To Katalon Demo CURA
    Sleep    2s
    ${Element}    Get WebElement    xpath://*[@id="to-top"]
    ${ClassAttr}    Get Element Attribute    ${Element}    style
    Should be empty    ${ClassAttr}
    Scroll down slowly
    Wait until element is visible    xpath://*[@id="to-top"]
    Element Attribute Value SHould Be    xpath://*[@id="to-top"]    style    display: block; position: fixed;
    Close Browser

TC4:
    [Documentation]    Check menu in home page not login
    Open Browser To Katalon Demo CURA
    Sleep    2s
    Click Element    xpath://*[@id="menu-toggle"]
    Element attribute value should be    xpath=//*[@id="sidebar-wrapper"]    class    active
    ${count}    Get Element Count    xpath://*[@id="sidebar-wrapper"]/ul/li
    ${result}    Convert to Integer    3
    Should be equal    ${count}    ${result}
    Close Browser

TC5:
    [Documentation]    Check menu content in home page not login
    Open Browser To Katalon Demo CURA
    Sleep    2s
    Click Element    xpath://*[@id="menu-toggle"]
    Sleep    2s
    Element attribute value should be    xpath=//*[@id="sidebar-wrapper"]    class    active
    Element Text Should Be    xpath://*[@id="sidebar-wrapper"]/ul/li[1]/a    CURA Healthcare
    Element Text Should Be    xpath://*[@id="sidebar-wrapper"]/ul/li[2]/a    Home
    Element Text Should Be    xpath://*[@id="sidebar-wrapper"]/ul/li[3]/a    Login
    Close Browser

TC6:
    [Documentation]    Check menu content in login page
    Open Browser And Go To Login
    Sleep    2s
    Click Element    xpath://*[@id="menu-toggle"]
    Sleep    2s
    Element attribute value should be    xpath=//*[@id="sidebar-wrapper"]    class    active
    Element Text Should Be    xpath://*[@id="sidebar-wrapper"]/ul/li[1]/a    CURA Healthcare
    Element Text Should Be    xpath://*[@id="sidebar-wrapper"]/ul/li[2]/a    Home
    Element Text Should Be    xpath://*[@id="sidebar-wrapper"]/ul/li[3]/a    Login
    Close Browser

TC7:
    [Documentation]    Check menu size in login page
    Open Browser And Go To Login
    Sleep    2s
    Click Element    xpath://*[@id="menu-toggle"]
    Sleep    2s
    Element attribute value should be    xpath=//*[@id="sidebar-wrapper"]    class    active
    ${count}    Get Element Count    xpath://*[@id="sidebar-wrapper"]/ul/li
    ${result}    Convert to Integer    3
    Should be equal    ${count}    ${result}
    Close Browser

TC8:
    [Documentation]    Check menu size home page, profile page, history page after login
    Open Browser and login
    Sleep    2s
    Click Element    xpath://*[@id="menu-toggle"]
    Sleep    2s
    Element attribute value should be    xpath=//*[@id="sidebar-wrapper"]    class    active
    ${count}    Get Element Count    xpath://*[@id="sidebar-wrapper"]/ul/li
    ${result}    Convert to Integer    5
    Should be equal    ${count}    ${result}
    Close Browser

TC9:
    [Documentation]    Check menu content home page, profile page, History page after login
    Open Browser and login
    Sleep    2s
    Click Element    xpath://*[@id="menu-toggle"]
    Sleep    2s
    Element attribute value should be    xpath=//*[@id="sidebar-wrapper"]    class    active
    Element Text Should Be    xpath://*[@id="sidebar-wrapper"]/ul/li[1]/a    CURA Healthcare
    Element Text Should Be    xpath://*[@id="sidebar-wrapper"]/ul/li[2]/a    Home
    Element Text Should Be    xpath://*[@id="sidebar-wrapper"]/ul/li[3]/a    History
    Element Text Should Be    xpath://*[@id="sidebar-wrapper"]/ul/li[4]/a    Profile
    Element Text Should Be    xpath://*[@id="sidebar-wrapper"]/ul/li[5]/a    Logout
    Close Browser

TC10:
    [Documentation]    Check appearance of time input in homepage
    Open Browser and login
    Sleep    2s
    Click Element    xpath://*[@id="appointment"]/div/div/form/div[4]/div/div/div
    Element Should Be Visible    xpath:/html/body/div/div[1]
    Close Browser

TC11:
    [Documentation]    Check number of element of time input
    Open Browser and login
    Sleep    2s
    Click Element    xpath://*[@id="appointment"]/div/div/form/div[4]/div/div/div
    Sleep    2s
    ${Count}    Get Element Count    xpath:/html/body/div/div
    ${result}    Convert to Integer    5
    Close Browser

TC12:
    [Documentation]    Check content of time input
    Open Browser and login
    Sleep    2s
    Click Element    xpath://*[@id="appointment"]/div/div/form/div[4]/div/div/div
    Sleep    2s
    Element Attribute Value Should Be    xpath:/html/body/div/div[1]    class    datepicker-days
    Element Attribute Value Should Be    xpath:/html/body/div/div[2]    class    datepicker-months
    Element Attribute Value Should Be    xpath:/html/body/div/div[3]    class    datepicker-years
    Element Attribute Value Should Be    xpath:/html/body/div/div[4]    class    datepicker-decades
    Element Attribute Value Should Be    xpath:/html/body/div/div[5]    class    datepicker-centuries
    Close Browser

TC13:
    [Documentation]    Turn off time input
    Open Browser and login
    Sleep    2s
    Click Element    xpath://*[@id="appointment"]/div/div/form/div[4]/div/div/div
    Sleep    2s
    Click Element    xpath://*[@id="txt_comment"]
    Element Should Not Be Visible    xpath:/html/body/div
    Close Browser

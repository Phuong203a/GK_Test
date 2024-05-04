*** Settings ***
Suite Setup       Open Browser and login
Test Setup        Check Session And Login If Needed
Resource          ../../Resources/resources.robot

*** Test Cases ***
Testcase 01
    [Documentation]    Verify the first time accessing
    List Selection Should Be    xpath://*[@id="combo_facility"]    Tokyo CURA Healthcare Center
    Checkbox Should Not Be Selected    id:chk_hospotal_readmission
    Radio Button Should Be Set To    programs    Medicare
    ${date}=    Get Value    xpath://*[@id="txt_visit_date"]
    Should Be Empty    ${date}
    ${comment}=    Get Value    id:txt_comment
    Should Be Empty    ${comment}
    Verify Placeholders    dd/mm/yyyy    xpath://*[@id="txt_visit_date"]
    Verify Placeholders    Comment    id:txt_comment
    Sleep    3

Testcase 02
    [Documentation]    Fill full the information
    ${facility}    Set Variable    Tokyo CURA Healthcare Center
    Select From List By Value    xpath://*[@id="combo_facility"]    ${facility}
    Select Checkbox    xpath://*[@id="chk_hospotal_readmission"]
    ${checkbox_status}=    Run Keyword And Return Status    Checkbox Should Be Selected    id:chk_hospotal_readmission
    ${checkbox}=    Set Variable If    ${checkbox_status}    Yes
    ...    ELSE    No
    ${program}    Set Variable    Medicaid
    Select Radio Button    programs    ${program}
    Click Element    xpath://*[@id="txt_visit_date"]
    Click Element    xpath:/html/body/div/div[1]/table/tbody/tr[5]/td[3]
    ${date}=    Get Value    xpath://*[@id="txt_visit_date"]
    ${comment}    Set Variable    This is a comment
    Input Text    id:txt_comment    ${comment}
    Sleep    3
    Click Element    id:btn-book-appointment
    Wait Until Element Is Visible    xpath://*[@id="summary"]/div/div/div[1]/h2
    Verify the URL    https://katalon-demo-cura.herokuapp.com/appointment.php#summary
    Verify information of booking    ${facility}    ${checkbox}    ${program}    ${date}    ${comment}
    Sleep    3
    Go to History
    Sleep    3
    Scroll Down Slowly
    Verify Last Panel Info    ${facility}    ${checkbox}    ${program}    ${date}    ${comment}

Testcase 03
    [Documentation]    Fill in all information except check box
    ${facility}    Set Variable    Tokyo CURA Healthcare Center
    Select From List By Value    xpath://*[@id="combo_facility"]    ${facility}
    ${checkbox_status}=    Run Keyword And Return Status    Checkbox Should Not Be Selected    id:chk_hospotal_readmission
    ${checkbox}=    Set Variable If    ${checkbox_status}    No
    ...    ELSE    Yes
    ${program}    Set Variable    None
    Select Radio Button    programs    ${program}
    Click Element    xpath://*[@id="txt_visit_date"]
    Click Element    xpath:/html/body/div/div[1]/table/tbody/tr[5]/td[3]
    ${date}=    Get Value    xpath://*[@id="txt_visit_date"]
    ${comment}    Set Variable    This is a comment
    Input Text    id:txt_comment    ${comment}
    Sleep    3
    Click Element    id:btn-book-appointment
    Wait Until Element Is Visible    xpath://*[@id="summary"]/div/div/div[1]/h2
    Verify the URL    https://katalon-demo-cura.herokuapp.com/appointment.php#summary
    Verify information of booking    ${facility}    ${checkbox}    ${program}    ${date}    ${comment}
    Sleep    3
    Go to History
    Sleep    3

    Scroll Down Slowly
    Verify Last Panel Info    ${facility}    ${checkbox}    ${program}    ${date}    ${comment}

Testcase 04
    [Documentation]    In the date field, enter the date using text
    ${facility}    Set Variable    Tokyo CURA Healthcare Center
    Select From List By Value    xpath://*[@id="combo_facility"]    ${facility}
    Select Checkbox    xpath://*[@id="chk_hospotal_readmission"]
    ${checkbox_status}=    Run Keyword And Return Status    Checkbox Should Be Selected    id:chk_hospotal_readmission
    ${checkbox}=    Set Variable If    ${checkbox_status}    Yes
    ...    ELSE    No
    ${program}    Set Variable    Medicaid
    Select Radio Button    programs    ${program}
    Click Element    xpath://*[@id="txt_visit_date"]
    Input Text    xpath://*[@id="txt_visit_date"]    XXX-YYY-ZZZ
    ${comment}    Set Variable    This is a comment
    Input Text    id:txt_comment    ${comment}
    Click Element    id:btn-book-appointment
    Sleep    3
    ${current_date}=    Get Current Date    result_format=%d/%m/%Y
    Wait Until Element Is Visible    xpath://*[@id="summary"]/div/div/div[1]/h2
    Verify the URL    https://katalon-demo-cura.herokuapp.com/appointment.php#summary
    Verify information of booking    ${facility}    ${checkbox}    ${program}    ${current_date}    ${comment}
    Sleep    3
    Go to History
    Sleep    3
    Scroll Down Slowly
    Verify Last Panel Info    ${facility}    ${checkbox}    ${program}    ${current_date}    ${comment}

Testcase 05
    [Documentation]    In the date field, enter the date in the past
    ${facility}    Set Variable    Tokyo CURA Healthcare Center
    Select From List By Value    xpath://*[@id="combo_facility"]    ${facility}
    Select Checkbox    xpath://*[@id="chk_hospotal_readmission"]
    ${checkbox_status}=    Run Keyword And Return Status    Checkbox Should Be Selected    id:chk_hospotal_readmission
    ${checkbox}=    Set Variable If    ${checkbox_status}    Yes
    ...    ELSE    No
    ${program}    Set Variable    Medicaid
    Select Radio Button    programs    ${program}
    Click Element    xpath://*[@id="txt_visit_date"]
    ${date}=    Set Variable    12/12/2012
    Input Text    xpath://*[@id="txt_visit_date"]    ${date}
    ${comment}    Set Variable    This is a comment
    Input Text    id:txt_comment    ${comment}
    Click Element    id:btn-book-appointment
    Wait Until Element Is Visible    xpath://*[@id="summary"]/div/div/div[1]/h2
    Verify the URL    https://katalon-demo-cura.herokuapp.com/appointment.php#summary
    Verify information of booking    ${facility}    ${checkbox}    ${program}    ${date}    ${comment}
    Sleep    3
    Go to History
    Sleep    3
    Scroll Down Slowly
    Verify Last Panel Info    ${facility}    ${checkbox}    ${program}    ${date}    ${comment}

Testcase 06
    [Documentation]    In the date field, enter an out of range date
    ${facility}    Set Variable    Tokyo CURA Healthcare Center
    Select From List By Value    xpath://*[@id="combo_facility"]    ${facility}
    Select Checkbox    xpath://*[@id="chk_hospotal_readmission"]
    ${checkbox_status}=    Run Keyword And Return Status    Checkbox Should Be Selected    id:chk_hospotal_readmission
    ${checkbox}=    Set Variable If    ${checkbox_status}    Yes
    ...    ELSE    No
    ${program}    Set Variable    Medicaid
    Select Radio Button    programs    ${program}
    Click Element    xpath://*[@id="txt_visit_date"]
    Input Text    xpath://*[@id="txt_visit_date"]    32/04/2024
    ${comment}    Set Variable    This is a comment
    Input Text    id:txt_comment    ${comment}
    Click Element    id:btn-book-appointment
    Wait Until Element Is Visible    xpath://*[@id="summary"]/div/div/div[1]/h2
    Verify the URL    https://katalon-demo-cura.herokuapp.com/appointment.php#summary
    Verify information of booking    ${facility}    ${checkbox}    ${program}    02/05/2024    ${comment}
    Sleep    3
    Go to History
    Sleep    3
    Scroll Down Slowly
    Verify Last Panel Info    ${facility}    ${checkbox}    ${program}    02/05/2024    ${comment}
    
Testcase 07
    [Documentation]    In the date field, enter the date with special characters
    ${facility}    Set Variable    Tokyo CURA Healthcare Center
    Select From List By Value    xpath://*[@id="combo_facility"]    ${facility}
    Select Checkbox    xpath://*[@id="chk_hospotal_readmission"]
    ${checkbox_status}=    Run Keyword And Return Status    Checkbox Should Be Selected    id:chk_hospotal_readmission
    ${checkbox}=    Set Variable If    ${checkbox_status}    Yes
    ...    ELSE    No
    ${program}    Set Variable    Medicaid
    Select Radio Button    programs    ${program}
    Click Element    xpath://*[@id="txt_visit_date"]
    Input Text    xpath://*[@id="txt_visit_date"]    01/@@/2024
    ${comment}    Set Variable    This is a comment
    Input Text    id:txt_comment    ${comment}
    Click Element    id:btn-book-appointment
    ${current_date}=    Get Current Date    result_format=%d/%m/%Y
    Wait Until Element Is Visible    xpath://*[@id="summary"]/div/div/div[1]/h2
    Verify the URL    https://katalon-demo-cura.herokuapp.com/appointment.php#summary
    Verify information of booking    ${facility}    ${checkbox}    ${program}    ${current_date}    ${comment}
    Sleep    3
    Go to History
    Sleep    3
    Scroll Down Slowly
    Verify Last Panel Info    ${facility}    ${checkbox}    ${program}    ${current_date}    ${comment}

Testcase 08
    [Documentation]    In the date field, enter the date with a negative number
    ${facility}    Set Variable    Tokyo CURA Healthcare Center
    Select From List By Value    xpath://*[@id="combo_facility"]    ${facility}
    Select Checkbox    xpath://*[@id="chk_hospotal_readmission"]
    ${checkbox_status}=    Run Keyword And Return Status    Checkbox Should Be Selected    id:chk_hospotal_readmission
    ${checkbox}=    Set Variable If    ${checkbox_status}    Yes
    ...    ELSE    No
    ${program}    Set Variable    Medicaid
    Select Radio Button    programs    ${program}
    Click Element    xpath://*[@id="txt_visit_date"]
    ${date}=    Set Variable    -18/05/2024
    Input Text    xpath://*[@id="txt_visit_date"]    ${date}
    ${new_date}=    Replace String    ${date}    -    ${EMPTY}
    ${comment}    Set Variable    This is a comment
    Input Text    id:txt_comment    ${comment}
    Click Element    id:btn-book-appointment
    Wait Until Element Is Visible    xpath://*[@id="summary"]/div/div/div[1]/h2
    Verify the URL    https://katalon-demo-cura.herokuapp.com/appointment.php#summary
    Verify information of booking    ${facility}    ${checkbox}    ${program}    ${new_date}    ${comment}
    Sleep    3
    Go to History
    Sleep    3
    Scroll Down Slowly
    Verify Last Panel Info    ${facility}    ${checkbox}    ${program}    ${new_date}    ${comment}

Testcase 09
    [Documentation]    In the date field, enter the date with decimal numbers
    ${facility}    Set Variable    Tokyo CURA Healthcare Center
    Select From List By Value    xpath://*[@id="combo_facility"]    ${facility}
    Select Checkbox    xpath://*[@id="chk_hospotal_readmission"]
    ${checkbox_status}=    Run Keyword And Return Status    Checkbox Should Be Selected    id:chk_hospotal_readmission
    ${checkbox}=    Set Variable If    ${checkbox_status}    Yes
    ...    ELSE    No
    ${program}    Set Variable    Medicaid
    Select Radio Button    programs    ${program}
    Click Element    xpath://*[@id="txt_visit_date"]
    Input Text    xpath://*[@id="txt_visit_date"]    7.9/04.5/2024
    ${comment}    Set Variable    This is a comment
    Input Text    id:txt_comment    ${comment}
    Click Element    id:btn-book-appointment
    ${current_date}=    Get Current Date    result_format=%d/%m/%Y
    Wait Until Element Is Visible    xpath://*[@id="summary"]/div/div/div[1]/h2
    Verify the URL    https://katalon-demo-cura.herokuapp.com/appointment.php#summary
    Verify information of booking    ${facility}    ${checkbox}    ${program}    ${current_date}    ${comment}
    Sleep    3
    Go to History
    Sleep    3
    Scroll Down Slowly
    Verify Last Panel Info    ${facility}    ${checkbox}    ${program}    ${current_date}    ${comment}

Testcase 10
    [Documentation]    In the date field, not enter the date
    ${facility}    Set Variable    Tokyo CURA Healthcare Center
    Select From List By Value    xpath://*[@id="combo_facility"]    ${facility}
    Select Checkbox    xpath://*[@id="chk_hospotal_readmission"]
    ${checkbox_status}=    Run Keyword And Return Status    Checkbox Should Be Selected    id:chk_hospotal_readmission
    ${checkbox}=    Set Variable If    ${checkbox_status}    Yes
    ...    ELSE    No
    ${program}    Set Variable    Medicaid
    Select Radio Button    programs    ${program}
    ${comment}    Set Variable    This is a comment
    Input Text    id:txt_comment    ${comment}
    Click Element    id:btn-book-appointment
    ${error_message}=    Execute JavaScript    return document.getElementById('txt_visit_date').validationMessage;
    Should Be Equal    ${error_message}    Please fill out this field.

Testcase 11
    [Documentation]    In the comment field, no enter the comment
    ${facility}    Set Variable    Tokyo CURA Healthcare Center
    Select From List By Value    xpath://*[@id="combo_facility"]    ${facility}
    Select Checkbox    xpath://*[@id="chk_hospotal_readmission"]
    ${checkbox_status}=    Run Keyword And Return Status    Checkbox Should Be Selected    id:chk_hospotal_readmission
    ${checkbox}=    Set Variable If    ${checkbox_status}    Yes
    ...    ELSE    No
    ${program}    Set Variable    Medicaid
    Select Radio Button    programs    ${program}
    Click Element    xpath://*[@id="txt_visit_date"]
    Click Element    xpath:/html/body/div/div[1]/table/tbody/tr[5]/td[3]
    ${date}=    Get Value    xpath://*[@id="txt_visit_date"]
    Click Element    id:btn-book-appointment
    Wait Until Element Is Visible    xpath://*[@id="summary"]/div/div/div[1]/h2
    Verify the URL    https://katalon-demo-cura.herokuapp.com/appointment.php#summary
    Verify information of booking    ${facility}    ${checkbox}    ${program}    ${date}    ${EMPTY}
    Sleep    3
    Go to History
    Sleep    3
    Scroll Down Slowly
    Verify Last Panel Info    ${facility}    ${checkbox}    ${program}    ${date}    ${EMPTY}

Testcase 12
    [Documentation]    The case where the user intentionally opens the dev tool to remove the required attribute
    ${facility}    Set Variable    Tokyo CURA Healthcare Center
    Select From List By Value    xpath://*[@id="combo_facility"]    ${facility}
    Select Checkbox    xpath://*[@id="chk_hospotal_readmission"]
    ${checkbox_status}=    Run Keyword And Return Status    Checkbox Should Be Selected    id:chk_hospotal_readmission
    ${checkbox}=    Set Variable If    ${checkbox_status}    Yes
    ...    ELSE    No
    ${program}    Set Variable    Medicaid
    Select Radio Button    programs    ${program}
    Execute JavaScript    document.getElementById('txt_visit_date').removeAttribute('required');
    ${comment}    Set Variable    This is a comment
    Input Text    id:txt_comment    ${comment}
    Click Element    id:btn-book-appointment
    Wait Until Element Is Visible    xpath://*[@id="summary"]/div/div/div[1]/h2
    Verify the URL    https://katalon-demo-cura.herokuapp.com/appointment.php#summary
    Verify information of booking    ${facility}    ${checkbox}    ${program}    ${EMPTY}    ${comment}
    Sleep    3
    Go to History
    Sleep    3
    Scroll Down Slowly
    Verify Last Panel Info    ${facility}    ${checkbox}    ${program}    ${EMPTY}    ${comment}

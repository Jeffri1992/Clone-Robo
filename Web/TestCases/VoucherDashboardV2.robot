*** Settings ***
Documentation          Testcases for Login
Resource               ../Libraries/CommonFunction.robot
Resource               PageObjects/DashboardV2Page/dashboardv2.robot
Suite Setup            Start Browser                  https://dasborv2.kompas.cloud/auth/login
Suite Teardown         Stop Browser
Force Tags           Squad-B


*** Test Cases ***
User Successfully Generate Voucher
    [Documentation]                         User Successfully Generate Voucher
    Login Dashboard V2
    Pick Bisnis Menu
    Generate Voucher

User Successfully Searching by Name and Channel
    [Documentation]                         User Successfully Searching by Name and Channel
    Pick Bisnis Menu
    Data Searching Voucher Name
    Data Searching Channel Name
    Data Searching Wrong Keyword

User Successfully Validate All Element
    [Documentation]                         User Successfully Validate All Element
    Pick Bisnis Menu
    Validating All Element


*** Keywords ***
Validate All Element Name Voucher
    [Documentation]                         Validate all element in Voucher Menu
    Get Text Menu Name Voucher
    Should Be Equal                         ${text_name_submenu_voucher}    List of Voucher
    Get Text Header Name

Validate Compare Row And Button
    [Documentation]                         Validate Compare Row and Button
    Get Element Action View Detail And Edit
    Get Count Row
    Should Be Equal                         ${LIST_COUNT_VIEW_DETAIL}    ${LIST_COUNT_ROW}
    Should Be Equal                         ${LIST_COUNT_VIEW_DETAIL}    ${LIST_COUNT_EDIT}
    Get Element Action View Detail And Edit
    Get Count Row
    Should Be Equal                         ${LIST_COUNT_VIEW_DETAIL}    ${LIST_COUNT_ROW}
    Should Be Equal                         ${LIST_COUNT_VIEW_DETAIL}    ${LIST_COUNT_EDIT}
    Wait Until Element Is Visible           ${page_name_submenu_voucher}

Validate Count Row Search
    [Documentation]                         Validate Count Row Search
    Get Count Row
    Sleep                          5s
    Should Be True                 ${LIST_COUNT_ROW} <= 10
    Sleep                          5s
    Wait And Click Element         ${list_row}
    Wait And Click Element         ${list_25}
    Wait And Click Element         ${column_header_voucher}
    Sleep                          5s
    Get Count Row
    Should Be True                 ${LIST_COUNT_ROW} <= 25

Validating All Element
    [Documentation]                        Validate Element Name Row And Button
    Validate All Element Name Voucher
    Validate Compare Row And Button
    Validate Count Row Search

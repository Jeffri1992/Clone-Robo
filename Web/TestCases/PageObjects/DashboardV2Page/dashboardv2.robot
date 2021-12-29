*** Settings ***
Documentation               Documentation
Variables                   dashboardv2_locator.yaml


*** Variables ***
@{LIST_MENU}    Voucher Title      Type                    Channel Type
...             Voucher Amount     Membership Package      Activation Date
...             Expired Date       Action


*** Keywords ***
Login Dashboard V2
    [Documentation]                  Successfully Login With Valid Parameters
    Wait And Input Text              ${field_email_login}        akunkompasid10@gmail.com
    Wait And Input Text              ${field_password_login}     Testing2020@
    Wait And Click Element           ${button_login}
    Wait Until Element Is Visible    ${label_success_login}
    ${login_success}                 Get Text    ${label_success_login}
    Should Be Equal                  ${login_success}    Dashboard

Pick Bisnis Menu
    [Documentation]                  Successfully Show Dropdown from Bisnis Menu
    Wait And Click Element           ${menu_header_bisnis_dv2}
    Wait And Click Element           ${submenu_voucher}

Get Text Menu Name Voucher
    [Documentation]                  Successfully Get Text Page Voucher
    ${TEXT_NAME_SUBMENU_VOUCHER}     Get Text                    ${page_name_submenu_voucher}
    Set Suite Variable               ${TEXT_NAME_SUBMENU_VOUCHER}

Get Text Header Name
    [Documentation]                  Successfully Get Text Header Name
    ${count_header}                  Get Element Count                   ${column_header_voucher}
    ${column_header_element}         Get Web All Element                 ${column_header_voucher}
    FOR    ${index}                       IN RANGE                       ${count_header}
           ${COLUMN_HEADER_ELEMENTS}      Get Text                       ${column_header_element[${index}]}
           Set Suite Variable             ${COLUMN_HEADER_ELEMENTS}
           Should Be Equal                ${COLUMN_HEADER_ELEMENTS}      ${LIST_MENU[${index}]}
    END

Get Count Row
    [Documentation]                Successfully Count Row
    ${LIST_COUNT_ROW}              Get Element Count           ${row_count}
    Set Suite Variable             ${LIST_COUNT_ROW}

Data Searching Voucher Name
    [Documentation]                        Successfully Searching Data by Voucher Name
    Wait Until Element Is Visible          ${row_by_name}
    ${GET_NAME_FIRST_ROW}                  Get Text                    ${row_by_name}
    Set Suite Variable                     ${GET_NAME_FIRST_ROW}
    Wait And Click Element                 ${field_search}
    Wait And Input Text                    ${field_search}             ${GET_NAME_FIRST_ROW}
    Sleep                                  5s

Data Searching Channel Name
    [Documentation]                Successfully Searching Data by Channel Name
    ${GET_CHANNEL_FIRST_ROW}       Get Text                    ${row_by_channel}
    Set Suite Variable             ${GET_CHANNEL_FIRST_ROW}
    Wait And Click Element         ${field_search}
    Wait And Input Text            ${field_search}             ${GET_CHANNEL_FIRST_ROW}
    Sleep                          5s

Data Searching Wrong Keyword
    [Documentation]                Successfully Searching Data by Wrong Keyword
    Clear Element Text             ${field_search}
    ${random_sentences}            Sentence
    Wait And Input Text            ${field_search}         ${random_sentences}
    Sleep                          5s

Get Element Action View Detail And Edit
    [Documentation]                      Successfully Get Element Action View and Edit Button
    Wait Until Element Is Visible        ${button_action_viewdetail}
    ${LIST_COUNT_VIEW_DETAIL}            Get Element Count            ${button_action_viewdetail}
    Set Suite Variable                   ${LIST_COUNT_VIEW_DETAIL}
    ${LIST_COUNT_EDIT}                   Get Element Count            ${button_action_edit}
    Set Suite Variable                   ${LIST_COUNT_EDIT}

Generate Voucher
    [Documentation]                Successfully Generate Voucher
    Wait And Click Element         ${button_generate_voucher}

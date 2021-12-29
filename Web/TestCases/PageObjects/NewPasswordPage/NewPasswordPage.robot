*** Settings ***
Documentation                        New Password Page
Variables                            newPassword_locators.yaml


*** Keywords ***
Input Password
    [Documentation]                  Input Email
    [Arguments]                      ${email}
    Input Text                       ${fieldPassword_newPasswordPage}       ${email}

Click Button Atur Ulang
    [Documentation]                  Click Button Atur Ulang
    Wait And Click Element           ${buttonAturUlang_newPasswordPage}

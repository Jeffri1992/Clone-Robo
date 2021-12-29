*** Settings ***
Documentation   Login page
Variables    login_locators.yaml


*** Keywords ***
Input Email
    [Documentation]    Input Email
    [Arguments]        ${email}
    Input Text         ${fieldEmail_loginPage}            ${email}

Input Password
    [Documentation]    Input password
    [Arguments]        ${password}
    Input Text         ${fieldPassword_loginPage}         ${password}

Click Button Sign In
    [Documentation]    Click button signin
    Click Button       ${buttonLogin_loginPage}

Click Checkbox Remember Me
    [Documentation]    Click Checkbox Remember Me
    Click Button       ${checkBoxRememberMe_loginPage}

Click Buttton Hide/Show Password
    [Documentation]    Click Button Hide/Show Password
    Click Button       ${buttonHidePassword_loginPage}

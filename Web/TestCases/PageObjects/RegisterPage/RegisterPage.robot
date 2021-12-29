*** Settings ***
Documentation                       Register page
Variables                            register_locators.yaml


*** Keywords ***
Input First Name
    [Documentation]                  Input First Name
    Wait Until Element Is Visible    ${fieldFirstName_registerPage}
    [Arguments]                      ${first_name}
    Input Text                       ${fieldFirstName_registerPage}    ${first_name}

Input Last Name
    [Documentation]                  Input Last Name
    [Arguments]                      ${last_name}
    Wait Until Element Is Visible    ${fieldLastName_registerPage}
    Input Text                       ${fieldLastName_registerPage}    ${last_name}

Input Email
    [Documentation]                  Input Email
    [Arguments]                      ${email}
    Input Text                       ${fieldEmail_registerPage}       ${email}

Input Password
    [Documentation]                   Input Password
    [Arguments]                      ${password}
    Input Text                       ${fieldPassword_registerPage}    ${password}

Checklist Recaptcha In Register
    [Documentation]                  Checklist Recaptcha
    Wait Until Element Is Visible    ${selectFrame_registerPage}
    Select Frame                     ${selectFrame_registerPage}
    Wait And Click Element           ${checkboxRecaptcha_registerPage}
    Unselect Frame
    Sleep    3

Click Button Daftar
    [Documentation]                  Click Button Daftar
    Wait And Click Element           ${btnDaftar_registerPage}

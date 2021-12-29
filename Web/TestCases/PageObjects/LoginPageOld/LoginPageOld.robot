*** Settings ***
Documentation   Login page old
Variables       loginOld_locators.yaml


*** Variables ***
${REGISTERED_EMAIL}         wulanxar@gmail.com
${REGISTERED_PASSWORD}      Kompas.id1993


*** Keywords ***
Input Email
    [Documentation]             Input Email
    [Arguments]                 ${email}
    Input Text                  ${fieldEmail_loginPage}       ${email}

Input Password
    [Documentation]             Input password
    [Arguments]                 ${password}
    Input Text                  ${fieldPassword_loginPage}    ${password}

Click Button Sign In
    [Documentation]             Click button signin
    Click Button                ${buttonLogin_loginPage}

Login Old
    [Documentation]         User Successfully Login With Registered Email
    Input Email             ${REGISTERED_EMAIL}
    Input Password          ${REGISTERED_PASSWORD}
    Click Button Sign In

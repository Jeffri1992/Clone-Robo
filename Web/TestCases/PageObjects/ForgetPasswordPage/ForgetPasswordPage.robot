*** Settings ***
Documentation                 Forget Password page
Variables    forgetPassword_locators.yaml


*** Keywords ***
Input Email
    [Documentation]                  Input Email
    [Arguments]                      ${email}
    Input Text                       ${fieldEmail_forgetPasswordPage}           ${email}

Checklist Recaptcha In Lupa Password
    [Documentation]                  Checklist Recaptcha In Lupa Password
    Wait Until Element Is Visible    ${selectFrame_forgetPasswordPage}          10
    Select Frame                     ${selectFrame_forgetPasswordPage}
    Wait And Click Element           ${checkboxRecaptcha_forgetPasswordPage}
    Unselect Frame
    Sleep                            5

Click Button Kirim Tautan
    [Documentation]                  Click Button Kirim Tautan
    Wait And Click Element           ${buttonKirimTautan_forgetPasswordPage}

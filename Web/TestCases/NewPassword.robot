*** Settings ***
Documentation    Testcases for New Password
Resource         ../Libraries/CommonFunction.robot
Resource         PageObjects/ForgetPasswordPage/ForgetPasswordPage.robot
Resource         PageObjects/NewPasswordPage/NewPasswordPage.robot
Resource         PageObjects/RegisterPage/RegisterPage.robot
Resource         PageObjects/1SecMailPage/1SecMailPage.robot
Resource         ../DataFactory/Register.robot
Resource         ../DataFactory/NewPassword.robot
Test Setup       Start Browser                      https://account.kompas.cloud/reset-password/new-password
Test Teardown    Stop Browser
Force Tags       Squad-E


*** Variables ***
${URL}                      https://account.kompas.cloud/register
${URL_SEC1MAIL}             https://www.1secmail.com/
${URL_FORGET_PASSWORD}      https://account.kompas.cloud/reset-password/send-link


*** Test Cases ***
User Successfully New Password With Valid Password
    [Documentation]                                     User successfully new password with valid password
    [Tags]                                              Stable
    ${random_pass}                                      Generate Random Password For New Password
    ...                                                 6   ${true}  ${true}  ${true}  ${true}
    Check Inbox In Email
    Wait Until Element Is Visible                       ${fieldPassword_newPasswordPage}
    NewPasswordPage.Input Password                      ${random_pass}
    Click Button Atur Ulang
    Verify Succesfull New Password

User Get Error New Password With Pass Less Than 6
    [Documentation]                                     User Get Error New Password With Pass Less Than 6
    [Tags]                                              Stable
    ${random_pass}                                      Generate Random Password For New Password
    ...                                                 4   ${true}  ${true}  ${true}  ${true}
    Check Inbox In Email
    Wait Until Element Is Visible                       ${fieldPassword_newPasswordPage}
    NewPasswordPage.Input Password                      ${random_pass}
    Click Button Atur Ulang
    Verify Error Password With Invalid Format

User Get Error New Password With Empty Password
    [Documentation]                                     User Get Error New Password With Empty Password
    [Tags]                                              Stable
    Check Inbox In Email
    Wait Until Element Is Visible                       ${fieldPassword_newPasswordPage}
    NewPasswordPage.Input Password                      ${EMPTY}
    Click Button Atur Ulang
    Verify Password Required

User Get Error New Password With Pass Only Lower Case
    [Documentation]                                     User Get Error New Password With Pass Only Lower Case
    [Tags]                                              Stable
    ${random_pass}                                      Generate Random Password For New Password
    ...                                                 15   ${false}  ${true}  ${false}  ${false}
    Check Inbox In Email
    Wait Until Element Is Visible                       ${fieldPassword_newPasswordPage}
    NewPasswordPage.Input Password                      ${random_pass}
    Click Button Atur Ulang
    Verify Error Password With Invalid Format

User Get Error New Password With Pass Only Upper Case
    [Documentation]                                     User Get Error New Password With Pass Only Upper Case
    [Tags]                                              Stable
    ${random_pass}                                      Generate Random Password For New Password
    ...                                                 15   ${true}   ${false}  ${false}  ${false}
    Check Inbox In Email
    Wait Until Element Is Visible                       ${fieldPassword_newPasswordPage}
    NewPasswordPage.Input Password                      ${random_pass}
    Click Button Atur Ulang
    Verify Error Password With Invalid Format

User Get Error New Password With Pass Only Numeric
    [Documentation]                                     User Get Error New Password With Pass Only Numeric
    [Tags]                                              Stable
    ${random_pass}                                      Generate Random Password For New Password
    ...                                                 15   ${false}  ${false}  ${true}  ${false}
    Check Inbox In Email
    Wait Until Element Is Visible                       ${fieldPassword_newPasswordPage}
    NewPasswordPage.Input Password                      ${random_pass}
    Click Button Atur Ulang
    Verify Error Password With Invalid Format

User Get Error New Password With Pass Only Special Char
    [Documentation]                                     User Get Error New Password With Pass Only Special Char
    [Tags]                                              Stable
    ${random_pass}                                      Generate Random Password For New Password
    ...                                                 15   ${false}   ${false}   ${false}   ${true}
    Check Inbox In Email
    Wait Until Element Is Visible                       ${fieldPassword_newPasswordPage}
    NewPasswordPage.Input Password                      ${random_pass}
    Click Button Atur Ulang
    Verify Error Password With Invalid Format

User Get Error New Password With Pass Lower And Upper Case
    [Documentation]                                     User Get Error New Password With Pass Lower And Upper Case
    [Tags]                                              Unstable
    ${random_pass}                                      Generate Random Password For New Password
    ...                                                 15   ${true}  ${true}  ${false}   ${false}
    Check Inbox In Email
    Wait Until Element Is Visible                       ${fieldPassword_newPasswordPage}
    NewPasswordPage.Input Password                      ${random_pass}
    Click Button Atur Ulang
    Verify Error Password With Invalid Format

User Succesfully View Element in New Password Form
    [Documentation]                                     User Succesfully View Element in New Password Form
    [Tags]                                              Stable
    Check Inbox In Email
    Verify Element In New Password Form

User Successfully View Strength bar Medium In Input password (Set New Password)
    [Documentation]                                     User Successfully View Strength bar Medium
    [Tags]                                              Stable
    ${random_pass}                                      Generate Random Password For New Password
    ...                                                 6    ${true}   ${true}   ${true}   ${true}
    Check Inbox In Email
    Wait Until Element Is Visible                       ${fieldPassword_newPasswordPage}
    NewPasswordPage.Input Password                      ${random_pass}
    Verify Medium Strength Bar In Input New Password

User Successfully View Strength bar Strong In Input password (Set New Password)
    [Documentation]                                     User Successfully View Strength bar Strong
    [Tags]                                              Stable
    ${random_pass}                                      Generate Random Password For New Password
    ...                                                 10   ${true}   ${true}   ${true}  ${true}
    Check Inbox In Email
    Wait Until Element Is Visible                       ${fieldPassword_newPasswordPage}
    NewPasswordPage.Input Password                      ${random_pass}
    Verify Strong Strength Bar In Input New Password

User Successfully Re-direct To Atur Ulang Sandi From Verification
    [Documentation]                                     User Successfully Re-direct To Atur Ulang Sandi
    [Tags]                                              Stable
    ${random_email}                                     Register New User
    ${string_email}                                     Split String        ${random_email}    @
    Click Verification Link                             ${string_email [0]}
    Click Link Ubah Sandi From Verification
    Verify Success Re-Direct


*** Keyword ***
Get Web Elements For Alert
    [Documentation]                                     Get Web Elements For Alert
    Wait Until Element Is Visible                       ${alertPassword_newPasswordPage}           20
    ${web_elements}                                     Get Web Elements    ${alertPassword_newPasswordPage}
    [Return]                                            ${web_elements}

Get Web Elements For Alert Success
    [Documentation]                                     Get Web Elements For Alert Success
    Wait Until Element Is Visible                       ${alertSuccess_newPasswordPage}
    ${web_elements}                                     Get Web Elements    ${alertSuccess_newPasswordPage}
    [Return]                                            ${web_elements}

Verify Succesfull New Password
    [Documentation]                                     Verify Succesfull New Password
    Wait Until Element Is Visible                       ${fieldPassword_newPasswordPage}
    ${web_elements}                                     Get Web Elements For Alert Success
    Wait Until Element Contains                         ${web_elements}      Kata Sandi Berhasil Diubah.

Verify Error Password With Invalid Format
    [Documentation]                                     Verify Error Password With Invalid Format
    Wait Until Element Is Visible                       ${fieldPassword_newPasswordPage}          20
    ${web_elements}                                     Get Web Elements For Alert
    Wait Until Element Contains                         ${web_elements}       Kata sandi lemah    20
    Wait Until Element Contains                         ${alertIndikatorBar_newPasswordPage}      Lemah.    20

Verify Password Required
    [Documentation]                                     Verify Password Required
    Wait Until Element Is Visible                       ${fieldPassword_newPasswordPage}
    ${web_elements}                                     Get Web Elements For Alert
    Wait Until Element Contains                         ${web_elements}       Kata sandi harus diisi

Verify Medium Strength Bar In Input New Password
    [Documentation]                                     Verify Medium Strength Bar In Input New Password
    Wait Until Element Is Visible                       ${fieldPassword_newPasswordPage}         10
    Wait Until Element Contains                         ${alertIndikatorBar_newPasswordPage}     Sedang.     30

Verify Strong Strength Bar In Input New Password
    [Documentation]                                     Verify Strong Strength Bar In Input New Password
    Wait Until Element Is Visible                       ${fieldPassword_newPasswordPage}         10
    Wait Until Element Contains                         ${alertIndikatorBar_newPasswordPage}     Kuat.       30

Register New User
    [Documentation]                                     Register New User (All Step Registrasi)
    ${random_firstname}  ${random_lastname}  ${random_email}  ${random_pass}   Generate Random Data For Register
    Go To                           ${URL}
    Input Register Form             ${random_firstname}  ${random_lastname}  ${random_email}  ${random_pass}
    Sleep                           2
    Checklist Recaptcha In Register
    Click Button Daftar
    Wait Until Element Is Visible   ${accountBar_registerPage}    10
    Go To                           ${URL_FORGET_PASSWORD}
    [Return]                        ${random_email}

Input Register Form
    [Documentation]      Input register form
    [Arguments]                     ${random_firstname}  ${random_lastname}  ${random_email}  ${random_pass}
    Input First Name                ${random_firstname}
    Input Last Name                 ${random_lastname}
    RegisterPage.Input Email        ${random_email}
    RegisterPage.Input Password     ${random_pass}

Forget Password Registered Email
    [Documentation]                                     Forget Password Registered Email
    ${registered_email}                                 Register New User
    Wait Until Element Is Visible                       ${fieldEmail_forgetPasswordPage}        20
    ForgetPasswordPage.Input Email                      ${registered_email}
    Checklist Recaptcha In Lupa Password
    Click Button Kirim Tautan
    ${string_email}                                     Split String        ${registered_email}    @
    [Return]                                            ${string_email [0]}

Check Inbox In Email
    [Documentation]                                     Check Inbox In Email
    ${string_email}                                     Forget Password Registered Email
    Go To                                               ${URL_SEC1MAIL}
    Wait Until Element Is Visible                       ${fieldEmail_sec1MailPage}
    Select From List By Label                           domain              @1secmail.com
    Input Email In Sec1Mail                             ${string_email}
    Click Button Check In Secmail
    Scroll To Element                                   ${tableMailBox_sec1MailPage}
    Click Link Forgot Password
    Open Link In New Tab
    Verify Page Atur Ulang Kata Sandi

Open Link In New Tab
    [Documentation]                                     Open Link In New Tab
    Wait Until Element Is Visible                       ${frameBodyEmail_sec1MailPage}       20
    Scroll To Element                                   ${frameBodyEmail_sec1MailPage}
    Select Frame                                        ${frameBodyEmail_sec1MailPage}
    ${link_href}                                        Get Element Attribute
    ...                                                 ${buttonAturUlang_sec1MailPage}      href
    Go To                                               ${link_href}
    Maximize Browser Window
    Unselect Frame

Verify Page Atur Ulang Kata Sandi
    [Documentation]                                     Open Link In New Tab
    ${curr_url}                                         Get Location
    Should Contain                                      ${curr_url}    reset-password/new-password     True
    Wait Until Page Contains                            Atur Ulang Kata Sandi       30
    Wait Until Element Is Visible                       ${fieldPassword_newPasswordPage}    20
    Element Should Be Visible                           ${fieldPassword_newPasswordPage}
    Element Should Be Enabled                           ${buttonAturUlang_newPasswordPage}

Verify Element In New Password Form
    [Documentation]                                     Verify Element In New Password Form
    Wait Until Element Is Visible                       ${fieldPassword_newPasswordPage}    20
    Element Should Be Visible                           ${fieldPassword_newPasswordPage}
    Element Should Be Visible                           ${buttonAturUlang_newPasswordPage}
    Element Should Be Enabled                           ${fieldPassword_newPasswordPage}
    Element Should Be Enabled                           ${buttonAturUlang_newPasswordPage}

Click Verification Link
    [Documentation]                                     Click Verification Link
    [Arguments]                                         ${string_email}
    Go To                                               ${URL_SEC1MAIL}
    Wait Until Element Is Visible                       ${fieldEmail_sec1MailPage}
    Select From List By Label                           domain              @1secmail.com
    Input Email In Sec1Mail                             ${string_email}
    Click Button Check In Secmail
    Scroll To Element                                   ${tableMailBox_sec1MailPage}
    Click Link Verifikasi

Click Link Ubah Sandi From Verification
    [Documentation]                                     Click Link Ubah Sandi From Verification
    Wait Until Element Is Visible                       ${frameBodyEmail_sec1MailPage}     20
    Scroll To Element                                   ${frameBodyEmail_sec1MailPage}
    Select Frame                                        ${frameBodyEmail_sec1MailPage}
    ${link_href}                                        Get Element Attribute
    ...                                                 ${linkAturUlang_sec1MailPage}      href
    Go To                                               ${link_href}
    Maximize Browser Window
    Unselect Frame

Verify Success Re-Direct
    [Documentation]                                     Verify Success Re-direct
    Wait Until Page Contains                            Atur Ulang Kata Sandi               30
    ${curr_url}                                         Get Location
    Should Contain                                      ${curr_url}    reset-password/new-password     True
    Wait Until Element Is Visible                       ${fieldPassword_newPasswordPage}    20
    Element Should Be Visible                           ${fieldPassword_newPasswordPage}
    Element Should Be Enabled                           ${buttonAturUlang_newPasswordPage}

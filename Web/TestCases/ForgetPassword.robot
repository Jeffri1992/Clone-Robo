*** Settings ***
Documentation    Testcases for Forget Password
Resource         ../Libraries/CommonFunction.robot
Resource         PageObjects/ForgetPasswordPage/ForgetPasswordPage.robot
Resource         PageObjects/RegisterPage/RegisterPage.robot
Resource         PageObjects/1SecMailPage/1SecMailPage.robot
Resource         ../DataFactory/Register.robot
Test Setup       Start Browser                  https://account.kompas.cloud/reset-password/send-link
Test Teardown    Stop Browser
Force Tags       Squad-E


*** Variables ***
${URL_SEC1MAIL}             https://www.1secmail.com/
${URL_REGISTER}             https://account.kompas.cloud/register
${URL_FORGET_PASSWORD}      https://account.kompas.cloud/reset-password/send-link


*** Test Cases ***
User Succesfull Forget Password With Registered Email
    [Documentation]                                 User Succesfull Forget Password With Registered Email
    [Tags]                                          Stable
    ${registered_email}                             Register New User
    Wait Until Element Is Visible                   ${fieldEmail_forgetPasswordPage}
    ForgetPasswordPage.Input Email                  ${registered_email}
    Checklist Recaptcha In Lupa Password
    Click Button Kirim Tautan
    Verify Succesfull Kirim Tautan

User Get Error Forget Password With Empty Email
    [Documentation]                                 User Get Error Forget Password With Empty Email
    [Tags]                                          Unstable
    Wait Until Element Is Visible                   ${fieldEmail_forgetPasswordPage}
    ForgetPasswordPage.Input Email                  ${Empty}
    Sleep                                           3
    Checklist Recaptcha In Lupa Password
    Click Button Kirim Tautan
    Verify Email Required

User Get Error Forget Password With Unregistered Email
    [Documentation]                                 User Get Error Forget Password With Unregistered Email
    [Tags]                                          Stable
    ${random_email}                                 Generate Random String             10        [NUMBERS][LETTERS]
    Wait Until Element Is Visible                   ${fieldEmail_forgetPasswordPage}
    ForgetPasswordPage.Input Email                  testsdet.${random_email}@1secmail.com
    Checklist Recaptcha In Lupa Password
    Click Button Kirim Tautan
    Verify Unregisted Email

User Get Error Forget Password With Invalid Email
    [Documentation]                                 User Get Error Forget Password With Invalid Email
    [Tags]                                          Stable
    ${random_email}                                 Generate Random String              10        [NUMBERS][LETTERS]
    Wait Until Element Is Visible                   ${fieldEmail_forgetPasswordPage}
    ForgetPasswordPage.Input Email                  testsdet.${random_email}1secmail.com
    Checklist Recaptcha In Lupa Password
    Click Button Kirim Tautan
    Verify Email Format Required                    testsdet.${random_email}1secmail.com

User Successfully View Element When Open Forgot Password Form
    [Documentation]                                 User successfully View Element When Open Forgot Password Form
    [Tags]                                          Stable
    Verify Element In Forget Password Page

User Get Error Without Checked Captcha In Forget Password
    [Documentation]                                 User Get Error Without Checked Captcha In Forget Password
    [Tags]                                          Stable
    ${random_email}                                 Generate Random String                 10         [NUMBERS][LETTERS]
    Wait Until Element Is Visible                   ${fieldEmail_forgetPasswordPage}
    ForgetPasswordPage.Input Email                  testsdet.${random_email}@1secmail.com
    Click Button Kirim Tautan
    Verify Unchecked Captcha

User Get Error When Click Kirim tautan Within 1 Minute In Forget Password
    [Documentation]                                 User Get Error When Click Kirim tautan Within 1 Minute
    [Tags]                                          Bugs
    Send Forget Password To Email
    Click Button Kirim Tautan
    Verify Error Within 1 Minute

User Successfull When Click Kirim tautan > 1 Minute In Forget Password
    [Documentation]                                 User Successfull When Click Kirim tautan > 1 Minute
    [Tags]                                          Unstable
    Send Forget Password To Email > 1 Minute
    Checklist Recaptcha In Lupa Password
    Click Button Kirim Tautan
    Verify Succesfull Kirim Tautan

User Succesfully Recieve Forgot Password Email
    [Documentation]                                 User Succesfully Recieve Forgot Password Email
    [Tags]                                          Unstable
    ${string_email}                                 Forget Password Registered Email
    Go To                                           ${URL_SEC1MAIL}
    Wait Until Element Is Visible                   ${fieldEmail_sec1MailPage}  20
    Select From List By Label                       domain                     @1secmail.com
    Input Email In Sec1Mail                         ${string_email}
    Click Button Check In Secmail
    Scroll To Element                               ${tableMailBox_sec1MailPage}
    Verify Receive Forgot Password

User Succesfully View Atribute Forgot Password Email
    [Documentation]                                 User Succesfully View Atribute Forgot Password Email
    [Tags]                                          Stable
    Check Inbox In Email
    Click Link Forgot Password
    Verify Atribute Forgot Password Email


*** Keyword ***
Get Web Elements For Alert
    [Documentation]                                 Get Web Elements For Alert
    Wait Until Element Is Visible                   ${alertEmail_forgetPasswordPage}
    ${web_elements}                                 Get Web Elements                   ${alertEmail_forgetPasswordPage}
    [Return]                                        ${web_elements}

Get Web Elements For Alert ReCaptcha
    [Documentation]                                 Get Web Elements For Alert ReCaptcha
    Wait Until Element Is Visible                   ${alertReCaptcha_forgetPasswordPage}
    ${web_elements}                                 Get Web Elements               ${alertReCaptcha_forgetPasswordPage}
    [Return]                                        ${web_elements}

Get Web Elements For Alert Success
    [Documentation]                                 Get Web Elements For Alert Success
    Wait Until Element Is Visible                   ${alertSuccess_forgetPasswordPage}
    ${web_elements}                                 Get Web Elements                 ${alertSuccess_forgetPasswordPage}
    [Return]                                        ${web_elements}

Get Web Elements For Alert Failed
    [Documentation]                                 Get Web Elements For Alert Success
    Wait Until Element Is Visible                   ${alertFailedWithin1Minutes_forgetPasswordPage}
    ${web_elements}                                 Get Web Elements    ${alertFailedWithin1Minutes_forgetPasswordPage}
    [Return]                                        ${web_elements}

Verify Succesfull Kirim Tautan
    [Documentation]                                 Verify Succesfull Kirim Tautan
    Wait Until Element Is Visible                   ${fieldEmail_forgetPasswordPage}
    ${web_elements}                                 Get Web Elements For Alert Success
    Wait Until Element Contains                     ${web_elements}        Tautan telah Dikirim.

Verify Error Within 1 Minute
    [Documentation]                                 Verify Error Within 1 Minute
    Wait Until Element Is Visible                   ${fieldEmail_forgetPasswordPage}
    ${web_elements}                                 Get Web Elements For Alert Failed
    Wait Until Element Contains                     ${web_elements}    Anda dapat mengirim ulang tautan dalam 1 menit.

Register New User
    [Documentation]                                 Register New User (All Step Registrasi)
    ${random_firstname}  ${random_lastname}  ${random_email}  ${random_pass}   Generate Random Data For Register
    Go To                           ${URL_REGISTER}
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
    Set Suite Variable              ${REGISTERED_EMAIL}    ${random_email}
    ${first_name_lower}             Convert To Lower Case          ${random_firstname} ${random_lastname}
    ${FIRST_NAME}                   Convert To Title Case          ${first_name_lower}
    Set Suite Variable              ${FIRST_NAME}

Verify Email Required
    [Documentation]                                 Verify Email Required
    Wait Until Element Is Visible                   ${fieldEmail_forgetPasswordPage}
    ${web_elements}                                 Get Web Elements For Alert
    Wait Until Page Contains                        Email harus diisi

Verify Unregisted Email
    [Documentation]                                 Verify Unregisted Email
    ${web_elements}                                 Get Web Elements For Alert
    Wait Until Element Contains                     ${web_elements}     Email tidak terdaftar.

Verify Email Format Required
    [Documentation]   Verify Email Format Required
    [Arguments]       ${email}
    ${valid_email}    Check Validate Email             ${email}
    ${web_elements}   Get Web Elements For Alert
    IF    ${valid_email} == False
       Wording Right Email Format    ${web_elements}
    END

Wording Right Email Format
    [Documentation]    Wording Right Email Format
    [Arguments]        ${web_elements}
    Wait Until Element Contains   ${web_elements}   Masukkan format email dengan benar

Verify Element In Forget Password Page
    [Documentation]                                 Verify Element In Forget Password Page
    Wait Until Element Is Visible                   ${fieldEmail_forgetPasswordPage}
    Element Should Be Visible                       ${fieldEmail_forgetPasswordPage}
    Element Should Be Visible                       ${buttonKirimTautan_forgetPasswordPage}
    Element Should Be Enabled                       ${fieldEmail_forgetPasswordPage}
    Element Should Be Enabled                       ${buttonKirimTautan_forgetPasswordPage}
    Page Should Contain                             reCAPTCHA

Verify Unchecked Captcha
    [Documentation]                                 Verify Unchecked Captcha
    ${web_elements}                                 Get Web Elements For Alert ReCaptcha
    Wait Until Element Contains                     ${web_elements}     reCAPTCHA harus dicentang.

Send Forget Password To Email
    [Documentation]                                 Send Forget Password to Email (Delay Under 1 Minute)
    ${registered_email}                             Register New User
    Wait Until Element Is Visible                   ${fieldEmail_forgetPasswordPage}
    ForgetPasswordPage.Input Email                  ${registered_email}
    Checklist Recaptcha In Lupa Password
    Click Button Kirim Tautan
    Sleep                                           15

Send Forget Password To Email > 1 Minute
    [Documentation]                                 Send Forget Password to Email (Delay More Then 1 Minute)
    ${registered_email}                             Register New User
    Wait Until Element Is Visible                   ${fieldEmail_forgetPasswordPage}
    ForgetPasswordPage.Input Email                  ${registered_email}
    Checklist Recaptcha In Lupa Password
    Click Button Kirim Tautan
    Sleep                                           60

Forget Password Registered Email
    [Documentation]                                 Forget Password Registered Email (All Proses Send Forget Password)
    ${registered_email}                             Register New User
    Wait Until Element Is Visible                   ${fieldEmail_forgetPasswordPage}
    ForgetPasswordPage.Input Email                  ${registered_email}
    Checklist Recaptcha In Lupa Password
    Click Button Kirim Tautan
    ${string_email}                                 Split String      ${registered_email}      @
    [Return]                                        ${string_email [0]}

Check Inbox In Email
    [Documentation]                                 Check Inbox In Email
    ${string_email}                                 Forget Password Registered Email
    Go To                                           ${URL_SEC1MAIL}
    Wait Until Element Is Visible                   ${fieldEmail_sec1MailPage}
    Select From List By Label                       domain          @1secmail.com
    Input Email In Sec1Mail                         ${string_email}
    Click Button Check In Secmail
    Scroll To Element                               ${tableMailBox_sec1MailPage}

Verify Receive Forgot Password
    [Documentation]                                 Verify Receive Forgot Password
    Wait Until Element Is Visible                   ${tableMailBox_sec1MailPage}
    Wait Until Element Is Enabled                   ${tableMailBox_sec1MailPage}
    Wait Until Page Contains                        Atur Ulang Kata Sandi Akun Kompas.id
    Wait Until Page Contains Element                ${linkInEmail_sec1MailPage}

Verify Atribute Forgot Password Email
    [Documentation]                                 Verify Atribute Forgot Password Email
    Wait Until Page Contains                        Message details
    Scroll To Element                               ${frameBodyEmail_sec1MailPage}
    Sleep                                           3
    Select Frame                                    ${frameBodyEmail_sec1MailPage}
    Content In Body Email
    Wait Until Element Is Visible                   ${buttonAturUlang_sec1MailPage}
    Wait Until Element Is Enabled                   ${buttonAturUlang_sec1MailPage}
    Scroll To Element                               ${footerEmail_sec1MailPage}
    Sleep                                           2
    Wait Until Page Contains                        Pesan dalam email ini ditujukan hanya untuk ${REGISTERED_EMAIL}

Content In Body Email
    [Documentation]                                 Content In Body Email
    Wait Until Page Contains                        Tautan ini akan kedaluwarsa pada
    Wait Until Page Contains                        Atur Ulang Kata Sandi
    Wait Until Page Contains                        ${FIRST_NAME}

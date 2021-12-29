*** Settings ***
Documentation                      Testcases for Register
Resource                           ../Libraries/CommonFunction.robot
Resource                           PageObjects/RegisterPage/RegisterPage.robot
Resource                           ../DataFactory/Register.robot
Suite Setup                        Start Browser                 https://account.kompas.cloud/register
Suite Teardown                     Stop Browser
Force Tags                         Squad-E


*** Variables ***
${URL_AFTER_REGISTER}              https://www.kompas.cloud/?status=sukses_login
${REGISTERED_EMAIL}                testsdet.hzHLf@1secmail.com
${INVALID_EMAIL}                   abc@abc


*** Test Cases ***
User Successfully Register With Valid Params (Medium Password)
    [Documentation]                User Successfully Register With Valid Params (medium password)
    ${random_firstname}  ${random_lastname}  ${random_email}  ${random_pass}   Generate Random Data For Register
    Input First Name               ${random_firstname}
    Input Last Name                ${random_lastname}
    Input Email                    ${random_email}
    Input Password                 ${random_pass}
    Checklist Recaptcha In Register
    Click Button Daftar
    Verify Succesfull Register

User Successfully Register With Valid Params (Strong Password)
    [Documentation]                User Successfully Register With Valid Params (Strong Password)
    ${rnd_firstname}  ${rnd_lastname}  ${rnd_email}  ${rnd_pass}
    ...                                Generate Random Data For Register   pass_spc_chars=${True}
    Go To Register
    Input First Name               ${rnd_firstname}
    Input Last Name                ${rnd_lastname}
    Input Email                    ${rnd_email}
    Input Password                 ${rnd_pass}
    Checklist Recaptcha In Register
    Click Button Daftar
    Verify Succesfull Register

User Successfully Register With Empty Last Name
    [Documentation]                User Successfully Register With Empty Last Name
    ${random_firstname}  ${random_lastname}  ${random_email}  ${random_pass}   Generate Random Data For Register
    Go To Register
    Input First Name               ${random_firstname}
    Input Last Name                ${Empty}
    Input Email                    ${random_email}
    Input Password                 ${random_pass}
    Checklist Recaptcha In Register
    Click Button Daftar
    Verify Succesfull Register

User Successfully Register With Apostrof Symbol in First Name and Last Name
    [Documentation]                User Successfully Register With Apostrof Symbol in First Name and Last Name
    ${random_firstname}  ${random_lastname}  ${random_email}  ${random_pass}   Generate Random Data For Register
    Go To Register
    Input First Name               '${random_firstname}'
    Input Last Name                '${random_lastname}'
    Input Email                    ${random_email}
    Input Password                 ${random_pass}
    Checklist Recaptcha In Register
    Click Button Daftar
    Verify Succesfull Register

User Get Error Register With Registered Email
    [Documentation]                User Get Error Register With Registered Email
    ${random_firstname}  ${random_lastname}  ${random_email}  ${random_pass}   Generate Random Data For Register
    Go To Register
    Input First Name               ${random_firstname}
    Input Last Name                ${random_lastname}
    Input Email                    ${REGISTERED_EMAIL}
    Input Password                 ${random_pass}
    Checklist Recaptcha In Register
    Click Button Daftar
    Verify Email Registered

User Get Error Register With Password Length Less Than 6 Characters
    [Documentation]                User Get Error Register With Password Length Less Than 6 Characters
    ${random_firstname}  ${random_lastname}  ${random_email}  ${random_pass}   Generate Random Data For Register
    ${less_char_pass}                Password    length=4    lower_case=${true}
    Go To Register
    Input First Name               ${random_firstname}
    Input Last Name                ${random_lastname}
    Input Email                    ${random_email}
    Input Password                 ${less_char_pass}
    Checklist Recaptcha In Register
    Click Button Daftar
    Verify Invalid Password

User Get Error Register With Empty First Name
    [Documentation]                User Get Error Register With Empty First Name
    ${random_firstname}  ${random_lastname}  ${random_email}  ${random_pass}   Generate Random Data For Register
    Go To Register
    Input First Name               ${Empty}
    Input Last Name                ${random_lastname}
    Input Email                    ${REGISTERED_EMAIL}
    Input Password                 ${random_pass}
    Checklist Recaptcha In Register
    Click Button Daftar
    Verify First Name Required

User Get Error Register With Empty Password
    [Documentation]                User Get Error Register With Empty Password
    ${random_firstname}  ${random_lastname}  ${random_email}  ${random_pass}   Generate Random Data For Register
    Go To Register
    Input First Name               ${random_firstname}
    Input Last Name                ${random_lastname}
    Input Email                    ${random_email}
    Input Password                 ${Empty}
    Checklist Recaptcha In Register
    Click Button Daftar
    Verify Password Required

User Get Error Register With Empty Email
    [Documentation]                User Get Error Register With Empty Email
    ${random_firstname}  ${random_lastname}  ${random_email}  ${random_pass}   Generate Random Data For Register
    Go To Register
    Input First Name               ${random_firstname}
    Input Last Name                ${random_lastname}
    Input Email                    ${Empty}
    Input Password                 ${random_pass}
    Checklist Recaptcha In Register
    Click Button Daftar
    Verify Email Required

User Get Error Register With All Empty Params
    [Documentation]                User Get Error Register With All Empty Params
    Go To Register
    Input First Name               ${Empty}
    Input Last Name                ${Empty}
    Input Email                    ${Empty}
    Input Password                 ${Empty}
    Checklist Recaptcha In Register
    Click Button Daftar
    Verify Fist Name, Email And Password Required

User Get Error Register With Invalid Email
    [Documentation]                User Get Error Register With Invalid Email
    ${random_firstname}  ${random_lastname}  ${random_email}  ${random_pass}   Generate Random Data For Register
    Go To Register
    Input First Name               ${random_firstname}
    Input Last Name                ${random_lastname}
    Input Email                    ${INVALID_EMAIL}
    Input Password                 ${random_pass}
    Checklist Recaptcha In Register
    Click Button Daftar
    Verify Invalid Email

User Get Error Register With Unchecked Captcha
    [Documentation]                User Get Error Register With Unchecked Captcha
    ${random_firstname}  ${random_lastname}  ${random_email}  ${random_pass}   Generate Random Data For Register
    Go To Register
    Input First Name               ${random_firstname}
    Input Last Name                ${random_lastname}
    Input Email                    ${random_email}
    Input Password                 ${random_pass}
    Click Button Daftar
    Verify Unchecked Captcha

User Get Error Register With Invalid First Name and Last Name
    [Documentation]                User Get Error Register With Invalid First Name
    ${random_firstname}  ${random_lastname}  ${random_email}  ${random_pass}
    ...                            Generate Random Data For Register    valid_char=${False}
    Go To Register
    Input First Name               ${random_firstname}
    Input Last Name                ${random_lastname}
    Input Email                    ${random_email}
    Input Password                 ${random_pass}
    Checklist Recaptcha In Register
    Click Button Daftar
    Verify First Name Required

User Can View Element When Open Register Page
    [Documentation]                User Can View Element When Open Register Page
    Go To Register
    Verify Element In Page Register


*** Keywords ***
Get Web Elements For Alert
    [Documentation]                   Get Web Elements For Alert
    Wait Until Element Is Visible     ${alert_registerPage}
    ${web_elements}                   Get Web Elements     ${alert_registerPage}
    [Return]                          ${web_elements}

Verify Email Registered
    [Documentation]                          Verify Email Registerd
    ${web_elements}                          Get Web Elements For Alert
    Wait Until Element Contains              ${web_elements}    Maaf, email telah digunakan

Verify First Name Required
    [Documentation]                          Verify First Name Required
    ${web_elements}                          Get Web Elements For Alert
    Wait Until Element Contains              ${web_elements}             Nama depan harus diisi

Verify Password Required
    [Documentation]                         Verify Password Required
    ${web_elements}                          Get Web Elements For Alert
    Wait Until Element Contains              ${web_elements}             Kata sandi harus diisi

Verify Email Required
    [Documentation]                          Verify Email Required
    ${web_elements}                          Get Web Elements For Alert
    Wait Until Element Contains              ${web_elements}             Email harus diisi

Verify Invalid Password
    [Documentation]                          Verify Invalid Password
    ${web_elements}                          Get Web Elements For Alert
    Wait Until Element Contains              ${web_elements}             Kata sandi lemah

Verify Invalid Email
    [Documentation]                          Verify Invalid Email
    ${web_elements}                          Get Web Elements For Alert
    Wait Until Element Contains              ${web_elements}             Masukkan format email dengan benar dan valid

Verify Fist Name, Email And Password Required
    [Documentation]                          Verify Fist Name, Email And Password Required
    ${web_elements}                          Get Web Elements For Alert
    Wait Until Element Contains              ${web_elements[0]}         Nama depan harus diisi
    Wait Until Element Contains              ${web_elements[1]}         Email harus diisi
    Wait Until Element Contains              ${web_elements[2]}         Kata sandi harus diisi

Verify Unchecked Captcha
    [Documentation]                          Verify Invalid Email
    ${web_elements}                          Get Web Elements For Alert
    Wait Until Element Contains              ${web_elements}             reCAPTCHA harus dicentang.

Verify Succesfull Register
    [Documentation]                          Verify Succesfull Register
    Wait Until Page Contains                 Periksa Email untuk Verifikasi Akun
    Wait Until Element Is Visible            ${imgKompas_registerPage}        15
    Wait Until Page Contains Element         ${imgProfile_registerPage}       15
    ${currURL}                               Get Location
    Should Contain                           ${currURL}         ${URL_AFTER_REGISTER}
    Title Should Be                          Kompas.id

Verify Element In Page Register
    [Documentation]                         Verify Element In Page Register
    Button Should Visible
    Field Should Visible
    Select Frame                            ${selectFrame_registerPage}
    Element Should Be Visible               ${checkboxRecaptcha_registerPage}
    Unselect Frame
    Hyperlink Should Visible

Button Should Visible
    [Documentation]      Button Should Visible
    Element Should Be Visible               ${buttonLoginWithGoogle_registerPage}
    Element Should Be Visible               ${buttonLoginWithFacebook_registerPage}
    Element Should Be Visible               ${buttonLoginWithApple_registerPage}
    Element Should Be Visible               ${buttonHidePassword_registerPage}

Field Should Visible
    [Documentation]     Field should visible
    Element Should Be Visible               ${fieldFirstName_registerPage}
    Element Should Be Visible               ${fieldLastName_registerPage}
    Element Should Be Visible               ${fieldEmail_registerPage}
    Element Should Be Visible               ${fieldPassword_registerPage}

Hyperlink Should Visible
    [Documentation]     Hyperlink should visible
    Element Should Be Visible               ${btnDaftar_registerPage}
    Element Should Be Visible               ${hyperLinkSilakanSyaratKetentuan_registerPage}
    Element Should Be Visible               ${hyperLinkSilakanMasuk_registerPage}

Go To Register
    [Documentation]                         Go To Register
    Go To                                   https://account.kompas.cloud/register
    Wait Until Element Contains             ${textDaftarAkun_registerPage}    Daftar Akun

*** Settings ***
Documentation         Testcases for Login
Resource              ../Libraries/CommonFunction.robot
Resource              PageObjects/LoginPage/LoginPage.robot
Resource              PageObjects/RegisterPage/RegisterPage.robot
Resource              ../DataFactory/Register.robot
Resource              ../DataFactory/Login.robot
Test Setup            Start Browser   https://account.kompas.cloud/login
Test Teardown         Stop Browser
Force Tags            Squad-E


*** Variables ***
${URL_AFTER_LOGIN}    https://www.kompas.cloud/?status=sukses_login&status_login=login
${URL_REGISTER}       https://account.kompas.cloud/register
${URL_LOGIN}          https://account.kompas.cloud/login
${URL_LOGOUT}         https://account.kompas.cloud/logout


*** Test Cases ***
User Successfully Login With Registered Email
    [Documentation]                    User Successfully Login With Registered Email
    [Tags]                             Unstable
    ${registered_email}                ${registered_password}                   Register New User
    Wait Login Password Appear
    LoginPage.Input Email              ${registered_email}
    LoginPage.Input Password           ${registered_password}
    Click Button Sign In
    Verify Succesfull Login

User Get Error Login With Empty Email
    [Documentation]   User Get Error Login With Empty Email
    [Tags]                             Stable
    ${random_email}   ${random_pass}   Generate Random Data For Login
    Wait Login Password Appear
    LoginPage.Input Email              ${Empty}
    LoginPage.Input Password           ${random_pass}
    Click Button Sign In
    Verify Email Required

User Get Error Login With Empty Password
    [Documentation]                    User Get Error Login With Empty Password
    [Tags]                             Stable
    ${random_email}   ${random_pass}   Generate Random Data For Login
    Wait Login Password Appear
    LoginPage.Input Email              ${random_email}
    LoginPage.Input Password           ${Empty}
    Click Button Sign In
    Verify Password Required

User Get Error Login With Mismatch Password
    [Documentation]                    User Get Error Login With Mismatch Password
    [Tags]                             Stable
    ${random_email}   ${random_pass}   Generate Random Data For Login
    Wait Login Password Appear
    LoginPage.Input Email              ${random_email}
    LoginPage.Input Password           ${random_pass}
    Click Button Sign In
    Verify Mismatch Password

User Get Error Login With Empty Password And Email
    [Documentation]                    User Get Error Login With Empty Password And Email
    [Tags]                             Stable
    Wait Login Password Appear
    LoginPage.Input Email              ${Empty}
    LoginPage.Input Password           ${Empty}
    Click Button Sign In
    Verify Email And Password Required

User Get Error Login 6th After Successfully Login 5X
    [Documentation]                    User Get Error Login 6th After Successfully Login 5X
    [Tags]                             Unstable
    ${registered_email}                ${registered_password}     Register New User
    Wait Login Password Appear
    Login More Than 1 Times Success    6                          ${registered_email}       ${registered_password}
    Sleep                              3
    LoginPage.Input Email              ${registered_email}
    LoginPage.Input Password           ${registered_password}
    Click Button Sign In
    Verify Fail Login 6X After Successfully Login 5X

User Get Error Login With Wrong Password 4x
    [Documentation]                    User Get Error Login With Wrong Password 4x
    [Tags]                             Stable
    ${random_email}   ${random_pass}   Generate Random Data For Login
    Wait Login Password Appear
    Login More Than 1 Times            4             ${random_email}           ${random_pass}
    LoginPage.Input Email              ${random_email}
    LoginPage.Input Password           ${random_pass}
    Click Button Sign In
    Verify Fail Login 4X

User Get Error Login With Wrong Password 5x
    [Documentation]                    User Get Error Login With Wrong Password 5x
    [Tags]                             Stable
    ${random_email}   ${random_pass}   Generate Random Data For Login
    Wait Login Password Appear
    Login More Than 1 Times            5              ${random_email}        ${random_pass}
    LoginPage.Input Email              ${random_email}
    LoginPage.Input Password           ${random_pass}
    Click Button Sign In
    Verify Fail Login 5X

User Get Error Login With Wrong Password 5x And Successfully Login
    [Documentation]                    User Get Error Login With Wrong Password 5x And Successfully Login
    [Tags]                             Unstable
    ${random_email}   ${random_pass}   Generate Random Data For Login
    ${registered_email}                ${registered_password}                     Register New User
    Wait Login Password Appear
    Login More Than 1 Times            6               ${registered_email}                           ${random_pass}
    Reload Page
    LoginPage.Input Email              ${registered_email}
    LoginPage.Input Password           ${registered_password}
    Click Button Sign In
    Verify Fail Login 5X And Successfully Login

User Get Error Login With Invalid Format Email
    [Documentation]                    User Get Error Login With Invalid Format Email
    [Tags]                             Stable
    ${random_email}   ${random_pass}   Generate Random Data For Login
    Wait Login Password Appear
    LoginPage.Input Email              ${random_email}
    LoginPage.Input Password           ${random_pass}
    Click Button Sign In
    Verify Email Format Required       ${random_email}

User Get Error Login With Unregisted Email
    [Documentation]                    User Get Error Login With Unregisted Email
    [Tags]                             Stable
    ${random_email}   ${random_pass}   Generate Random Data For Login
    Wait Login Password Appear
    LoginPage.Input Email              ${random_email}
    LoginPage.Input Password           ${random_pass}
    Click Button Sign In
    Verify Unregisted Email

User Succesfully View Element In Login Form
    [Documentation]                    User Succesfully View Element In Login Form
    [Tags]                             Stable
    Verify Element In Page Login

User Successfully View Password and Email Full Filled After Remember Me
    [Documentation]                    User Successfully View Password and Email Full Filled After Remember Me
    [Tags]                             Unstable
    ${registered_email}                ${registered_password}                        Register New User
    Wait Login Password Appear
    LoginPage.Input Email              ${registered_email}
    LoginPage.Input Password           ${registered_password}
    Click Checkbox Remember Me
    Click Button Sign In
    Sleep                              3
    Go To                              ${URL_LOGOUT}
    Verify Email And Password Full Filled        ${registered_email}                 ${registered_password}


*** Keyword ***
Get Web Elements For Alert
    [Documentation]                  Get Web Elements For Alert
    Wait Until Element Is Visible    ${alertEmailPassword_loginPage}
    ${web_elements}                  Get Web Elements          ${alertEmailPassword_loginPage}
    [Return]                         ${web_elements}

Get Web Elements For Alert Failed Temp
    [Documentation]                  Get Web Elements For Alert Failed Temp
    Wait Until Element Is Visible    ${alertFailedTemp_loginPage}
    ${web_elements}                  Get Web Elements          ${alertFailedTemp_loginPage}
    [Return]                         ${web_elements}

Verify Email Required
    [Documentation]                  Verify Email Required
    ${web_elements}                  Get Web Elements For Alert
    Wait Until Element Contains      ${web_elements}           Email harus diisi.

Verify Password Required
    [Documentation]                  Verify Password Required
    ${web_elements}                  Get Web Elements For Alert
    Wait Until Element Contains      ${web_elements}          Kata sandi harus diisi.

Verify Mismatch Password
    [Documentation]                   Verify Mismatch Password
    ${web_elements}                   Get Web Elements For Alert
    Wait Until Element Contains       ${web_elements}         Maaf, email atau kata sandi Anda salah.

Verify Email And Password Required
    [Documentation]                   Verify Email And Password Required
    ${web_elements}                   Get Web Elements For Alert
    Wait Until Element Contains       ${web_elements[0]}       Email harus diisi.
    Wait Until Element Contains       ${web_elements[1]}       Kata sandi harus diisi.

Verify Succesfull Login
    [Documentation]                   Verify Succesfull Login
    Wait Until Element Is Visible     ${accountBar_registerPage}
    Location Should Contain           ${URL_AFTER_LOGIN}
    Title Should Be                   Kompas.id

Verify Fail Login 6X After Successfully Login 5X
    [Documentation]                   Verify Fail Login 6X After Successfully Login 5X
    Wait Until Page Contains          Penggunaan Perangkat Penuh Akun
    Location Should Contain           device-list
    Page Should Contain               Anda sudah aktif di 5 perangkat.

Verify Fail Login 4X
    [Documentation]                   Verify Fail Login 4X
    ${web_elements}                   Get Web Elements For Alert Failed Temp
    Wait Until Element Contains       ${web_elements}            Tersisa 1 kesempatan lagi untuk percobaan masuk

Verify Fail Login 5X
    [Documentation]                   Verify Fail Login 5X
    ${web_elements}                   Get Web Elements For Alert Failed Temp
    Wait Until Element Contains       ${web_elements}            Anda telah gagal masuk 5 kali. Silakan coba lagi dalam

Verify Fail Login 5X And Successfully Login
    [Documentation]                   Verify Succesfull Login 5X And Successfully Login
    ${web_elements}                   Get Web Elements For Alert Failed Temp
    Wait Until Element Contains       ${web_elements}            Anda belum berhasil masuk Kompas.id.

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
    Wait Until Element Contains   ${web_elements}   Masukkan format email yang benar dan valid.

Verify Unregisted Email
    [Documentation]                   Verify Unregisted Email
    ${web_elements}                   Get Web Elements For Alert
    Wait Until Element Contains       ${web_elements}             Maaf, email atau kata sandi Anda salah.

Verify Element In Page Login
    [Documentation]                   Verify Element In Page Login
    Button Should Visible
    Button Should Enable
    Checkbox Should Visible And Enable
    Hyperlink Shoud Visible And Enable
    Field Should Visible

Button Should Visible
    [Documentation]     Button should visible
    Element Should Be Visible         ${buttonLogin_loginPage}
    Element Should Be Visible         ${buttonLoginWithGoogle_loginPage}
    Element Should Be Visible         ${buttonLoginWithFacebook_loginPage}
    Element Should Be Visible         ${buttonLoginWithApple_loginPage}
    Element Should Be Visible         ${buttonHidePassword_loginPage}

Button Should Enable
    [Documentation]     Button should enable
    Element Should Be Enabled         ${buttonLogin_loginPage}
    Element Should Be Enabled         ${buttonLoginWithGoogle_loginPage}
    Element Should Be Enabled         ${buttonLoginWithFacebook_loginPage}
    Element Should Be Enabled         ${buttonLoginWithApple_loginPage}
    Element Should Be Enabled         ${buttonHidePassword_loginPage}

Checkbox Should Visible And Enable
    [Documentation]     Checkbox Should Visible And Enable
    Element Should Be Visible         ${checkBoxRememberMe_loginPage}
    Checkbox Should Not Be Selected   ${checkBoxRememberMe_loginPage}
    Element Should Be Enabled         ${checkBoxRememberMe_loginPage}

Hyperlink Shoud Visible And Enable
    [Documentation]     Hyperlink Shoud Visible And Enable
    Element Should Be Visible         ${hyperLinkForgetPassword_loginPage}
    Element Should Be Visible         ${hyperLinkRegister_loginPage}
    Element Should Be Enabled         ${hyperLinkForgetPassword_loginPage}
    Element Should Be Enabled         ${hyperLinkRegister_loginPage}

Field Should Visible
    [Documentation]     Field Should visible
    Element Should Be Visible         ${fieldEmail_loginPage}
    Element Should Be Visible         ${fieldPassword_loginPage}
    Element Should Be Enabled         ${fieldEmail_loginPage}
    Element Should Be Enabled         ${fieldPassword_loginPage}

Verify Email And Password Full Filled
    [Documentation]                       Verify Email And Password Full Filled
    [Arguments]                           ${registered_email}           ${registered_password}
    Wait Until Element Is Visible         ${buttonHidePassword_loginPage}
    Sleep                                 2
    Click Buttton Hide/Show Password
    Sleep                                 2
    Wait Until Element Is Enabled         ${fieldEmail_loginPage}
    Wait Until Element Is Enabled         ${fieldPassword_loginPage}
    Page Should Contain Textfield         ${fieldEmail_loginPage}        ${registered_email}
    Page Should Contain Textfield         ${fieldPassword_loginPage}     ${registered_password}
    Sleep                                 2

Register New User
    [Documentation]                 Register New User
    ${random_firstname}  ${random_lastname}  ${random_email}  ${random_pass}   Generate Random Data For Register
    Go To                           ${URL_REGISTER}
    Input Register Form             ${random_firstname}  ${random_lastname}  ${random_email}  ${random_pass}
    Sleep                           2
    Checklist Recaptcha In Register
    Click Button Daftar
    Wait Until Element Is Visible   ${accountBar_registerPage}        20
    Go To                           ${URL_LOGOUT}
    [Return]                        ${random_email}                   ${random_pass}

Input Register Form
    [Documentation]      Input register form
    [Arguments]                     ${random_firstname}  ${random_lastname}  ${random_email}  ${random_pass}
    Input First Name                ${random_firstname}
    Input Last Name                 ${random_lastname}
    RegisterPage.Input Email        ${random_email}
    RegisterPage.Input Password     ${random_pass}

Login More Than 1 Times
    [Documentation]                   Login More Than 1 Times (All Looping Login Stay In Login Form)
    [Arguments]                       ${times}                   ${email}       ${password}
    ${index}                          Set Variable               1
    FOR                               ${i}                       IN RANGE       1       ${times}
      EXIT FOR LOOP IF                  ${index} == ${times}
      Sleep                             2
      LoginPage.Input Email             ${email}
      LoginPage.Input Password          ${password}
      Sleep                             2
      Click Button Sign In
      ${index}                          Evaluate                   ${index}+1
      Sleep                             2
    END

Login More Than 1 Times Success
    [Documentation]                   Login More Than 1 Times Success (All Looping Login Need Go back To Login Form)
    [Arguments]                       ${times}                  ${email}        ${password}
    ${index}                          Set Variable              1
    FOR                               ${i}                      IN RANGE        1        ${times}
      EXIT FOR LOOP IF                  ${index} == ${times}
      Sleep                             2
      LoginPage.Input Email             ${email}
      LoginPage.Input Password          ${password}
      Click Button Sign In
      ${index}                          Evaluate                  ${index}+1
      Sleep                             2
      Go Back
      Sleep                             2
    END

Wait Login Password Appear
    [Documentation]                    Element Visible
    Wait Until Element Is Visible      ${fieldEmail_loginPage}                   10
    Wait Until Element Is Visible      ${fieldPassword_loginPage}                10

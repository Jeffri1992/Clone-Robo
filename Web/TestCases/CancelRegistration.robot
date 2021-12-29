*** Settings ***
Documentation      Testcases for Cancel Registration
Resource           ../Libraries/CommonFunction.robot
Resource           PageObjects/RegisterPage/RegisterPage.robot
Resource           PageObjects/CancelPage/CancelPage.robot
Resource           PageObjects/1SecMailPage/1SecMailPage.robot
Resource           ../DataFactory/Register.robot
Suite Setup        Start Browser        https://account.kompas.cloud/register
Suite Teardown     Stop Browser
Force Tags       Squad-E


*** Variables ***
${URL_AFTER_CLICK_VERIFICATION}         https://www.1secmail.com/mailbox/
${URL_AFTER_CANCEL_REGISTRATION}        https://account.kompas.cloud/login


*** Test Cases ***
User Successfully Delete Account
    [Documentation]                     User Successfully Delete Account
    ${hostname_email}                   Registration New User
    Go To SecMail
    Input Email In Sec1Mail             ${hostname_email}
    Select Domain In SecMail
    Click Button Check In SecMail
    Click Link Verifikasi
    Click Link Cancel Registration
    Verify Successful Cancel Registration

User Can View Atribute When Open Email Account
    [Documentation]                     User Can View Atribute When Open Email Account
    ${hostname_email}                   Registration New User
    Go To SecMail
    Input Email In Sec1Mail             ${hostname_email}
    Select Domain In SecMail
    Click Button Check In SecMail
    Click Link Verifikasi
    Verify Atribute When Open Email Account


*** Keywords ***
Registration New User
    [Documentation]                  Registration New User
    ${random_firstname}  ${random_lastname}  ${random_email}  ${random_pass}   Generate Random Data For Register
    Go To Register
    Input Register Form    ${random_firstname}  ${random_lastname}  ${random_email}  ${random_pass}
    Checklist Recaptcha In Register
    Click Button Daftar
    Success Email Page
    ${hostname_email}                Split String           ${RANDOM_EMAIL}     @
    [Return]                         ${hostname_email [0]}

Input Register Form
    [Documentation]                  Input Register Form
    [Arguments]                      ${random_firstname}    ${random_lastname}  ${random_email}  ${random_pass}
    Input First Name                 ${random_firstname}
    Input Last Name                  ${random_lastname}
    Input Email                      ${random_email}
    Input Password                   ${random_pass}
    Set Suite Variable               ${FIRSTNAME}           ${random_firstname}
    Set Suite Variable               ${REGISTERED_EMAIL}    ${random_email}

Click Link Cancel Registration
    [Documentation]                  Click Link Batal Daftar
    Select Frame                     ${frameBodyEmail_sec1MailPage}
    ${link_href}                     Get Element Attribute          ${linkCancelRegis_sec1mailPage}    href
    Go To                            ${link_href}
    Unselect Frame
    Verify Element In Page Batal Daftar

Verify Element In Page Batal Daftar
    [Documentation]                  Verify Element In Page Batal Daftar
    Wait Until Page Contains         Yakin Ingin Membatalkan Pendaftaran Akun Kompas.id?
    Wait Until Element Is Visible    ${btnCancelRegis_cancelPage}
    Title Should Be                  Kompas.id

Verify Successful Cancel Registration
    [Documentation]                     Verify Successful Cancel Registration
    Click Button Batalkan Pendaftaran
    Wait Until Page Contains            Pendaftaran Akun Berhasil Dibatalkan.
    Wait Until Element Is Visible       ${alertBerhasilDibatalkan_cancelPage}
    ${curr_url}                         Get Location
    Should Be Equal                     ${curr_url}    ${URL_AFTER_CANCEL_REGISTRATION}
    Title Should Be                     Kompas.id

Verify Atribute When Open Email Account
    [Documentation]                     Verify Atribute When Open Email Account
    Wait Until Page Contains            Message details
    ${curr_url}                         Get Location
    Should Contain                      ${curr_url}    ${URL_AFTER_CLICK_VERIFICATION}
    Select Frame                        ${frameBodyEmail_sec1MailPage}
    Scroll To Element                   ${linkCancelRegis_sec1mailPage}
    Wait Until Page Contains            Hai, ${FIRSTNAME}
    Wait Until Page Contains            Email verifikasi ini akan kedaluwarsa
    Element Should Be Visible           ${linkCancelRegis_sec1mailPage}
    Wait Until Page Contains            ${REGISTERED_EMAIL}

Success Email Page
    [Documentation]                     Verify Succesfull Register
    Wait Until Page Contains            Periksa Email untuk Verifikasi Akun
    Wait Until Page Contains Element    ${imgProfile_registerPage}    10

Go To Register
    [Documentation]                     Go To Register
    Go To                               https://account.kompas.cloud/register
    Wait Until Element Contains         ${textDaftarAkun_registerPage}    Daftar Akun

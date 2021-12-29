*** Settings ***
Documentation      Testcases for User Verification
Resource           ../Libraries/CommonFunction.robot
Resource           PageObjects/RegisterPage/RegisterPage.robot
Resource           PageObjects/VerificationPage/VerificationPage.robot
Suite Setup        Start Browser        https://account.kompas.cloud/register
Suite Teardown     Stop Browser
Force Tags       Squad-E


*** Variables ***
${URL_AFTER_CLICK_VERIFICATION}         https://www.1secmail.com/mailbox/
${HOST_NAME}                            testsdet.


*** Test Cases ***
User Successfully Verify Account With Registered Email
    [Documentation]                     User Successfully Verify Account With Registered Email
    [Tags]                              test2
    Generate Register
    Generate Receive Email Verification
    Click Button Verifikasi Akun
    Verify Successful Account

User Get Error Verify Account With Verified Email
    [Documentation]                     User Get Error Verify Account With Verified Email
    Generate Register
    Generate Receive Email Verification
    Click Button Verifikasi Akun More Than One Time
    Verify Expired Account

User Can View Atribute When Open Email Account
    [Documentation]                     User Can View Atribute When Open Email Account
    Generate Register
    Generate Receive Email Verification
    Verify Atribute When Open Email Account


*** Keywords ***
Generate Register
    [Documentation]                    Generate Register
    Go To Register
    ${RANDOM_FIRSTNAME}                 First Name
    ${random_lastname}                  Last Name
    ${email}                            Email                domain=1secmail.com
    Set Suite Variable                  ${RANDOM_FIRSTNAME}
    Set Suite Variable                  ${RANDOM_EMAIL}      ${HOST_NAME}${email}
    Input First Name                    ${RANDOM_FIRSTNAME}
    Input Last Name                     ${random_lastname}
    Input Email Password Register Page
    Success Email Page

Input Email Password Register Page
    [Documentation]    Input Email Password Register Page
    RegisterPage.Input Email            ${RANDOM_EMAIL}
    ${random_pass}                      Password             length=8                special_chars=${true}
    ...                                 digits=${true}       upper_case=${true}      lower_case=${true}
    RegisterPage.Input Password         ${random_pass}
    Checklist Recaptcha In Register
    Click Button Daftar

Success Email Page
    [Documentation]    Success Email Page
    ${registered_email}                 Set Variable         ${RANDOM_EMAIL}
    ${STRING_EMAIL}                     Split String         ${registered_email}     @
    Set Suite Variable                  ${STRING_EMAIL}
    Wait Until Page Contains            Periksa Email untuk Verifikasi Akun
    Wait Until Element Is Visible       ${imgProfile_registerPage}               15
    Wait Until Element Is Visible       ${accountBar_registerPage}               15

Generate Receive Email Verification
    [Documentation]                  Generate Receive Email Verification
    Go To 1secMail
    Wait Until Page Contains         1secMail
    Input Host Name                  ${STRING_EMAIL [0]}
    Select Domain
    Click Button Check
    Wait Until Element Is Visible    ${linkMailbox_verificationPage}
    Scroll To Element                ${linkMailbox_verificationPage}
    Click Mailbox

Click Button Verifikasi Akun
    [Documentation]      Click Button Verifikasi Akun
    Select Frame         ${selectFrame_verificationPage}
    ${link_href}         Get Element Attribute      ${linkVerifikasiAkun_verificationPage}    href
    Go To                ${link_href}
    Unselect Frame

Click Button Verifikasi Akun More Than One Time
    [Documentation]             Click Button Verifikasi Akun More Than One Time
    Select Frame                ${selectFrame_verificationPage}
    ${link_href}                Get Element Attribute      ${linkVerifikasiAkun_verificationPage}    href
    Go To                       ${link_href}
    Verify Successful Account
    Unselect Frame
    Go Back
    Select Frame                ${selectFrame_verificationPage}
    ${link_href}                Get Element Attribute       ${linkVerifikasiAkun_verificationPage}    href
    Go To                       ${link_href}
    Unselect Frame

Verify Successful Account
    [Documentation]                     Verify Successful Account
    Wait Until Page Contains            Akun Berhasil di Verifikasi
    Wait Until Element Is Visible       ${btnMasuk_verificationPage}
    Title Should Be                     Kompas.id

Verify Expired Account
    [Documentation]                     Verify Expired Account
    Wait Until Page Contains            Tautan Verifikasi Sudah Tidak Berlaku
    Title Should Be                     Kompas.id

Verify Atribute When Open Email Account
    [Documentation]                     Verify Atribute When Open Email Account
    Wait Until Page Contains Element    ${textMessageDetails_verificationPage}
    ${curr_url}                         Get Location
    Should Contain                      ${curr_url}                                ${URL_AFTER_CLICK_VERIFICATION}
    Select Frame                        ${selectFrame_verificationPage}
    Scroll To Element                   ${linkVerifikasiAkun_verificationPage}
    Wait Until Page Contains            Hai, ${RANDOM_FIRSTNAME}
    Wait Until Page Contains            Email verifikasi ini akan kedaluwarsa
    Element Should Be Visible           ${linkVerifikasiAkun_verificationPage}
    Wait Until Page Contains            ${RANDOM_EMAIL}
    Unselect Frame

Go To Register
    [Documentation]                     Go To Register
    Go To                               https://account.kompas.cloud/register
    Wait Until Element Contains         ${textDaftarAkun_registerPage}            Daftar Akun

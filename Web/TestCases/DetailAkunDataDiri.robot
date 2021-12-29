*** Settings ***
Documentation    Testcases for Detail Akun Data Diri
Resource         ../Libraries/CommonFunction.robot
Resource         PageObjects/DetailAkunDataDiriPage/DetailAkunDataDiriPage.robot
Resource         PageObjects/MyAccountPage/MyAccountPage.robot
Resource         PageObjects/LoginPage/LoginPage.robot
Resource         PageObjects/RegisterPage/RegisterPage.robot
Resource         ../DataFactory/Register.robot
Resource         ../DataFactory/DetailAkunDataDiri.robot
Variables        ../Resource/Account.yaml
Test Setup       Start Browser                      https://account.kompas.cloud/login
Test Teardown    Stop Browser
Force Tags       Squad-E


*** Variables ***
${URL_REGISTER}       https://account.kompas.cloud/register
${URL_LOGIN}          https://account.kompas.cloud/login
${URL_KELOLA_AKUN}    https://account.kompas.cloud/manage-account/my-account
${URL_DETAIL_AKUN}    https://account.kompas.cloud/manage-account/account-detail/personal-data


*** Test Cases ***
User Successfull Redirect To Detail Akun Page
    [Documentation]                 User Successfull Redirect To Detail Akun Page
    Redirect To Kelola Akun Page
    Click Detail Akun Section
    Verify User Succesfully Re-Direct

User Successfull View Element In Detail Akun Page
    [Documentation]                 User Successfull View Element In Detail Akun Page
    Redirect To Kelola Akun Page
    Click Detail Akun Section
    Verify Element In Detail Akun Page

User Successfull View Element In Data Diri Form Page
    [Documentation]                 User Successfull View Element In Data Diri Form Page
    Redirect To Kelola Akun Page
    Click Detail Akun Section
    Click Ubah Data Diri
    Verify Element In Data Diri Form

User Successfull Change Personal Information with Valid Data
    [Documentation]                 User Successfull Change Personal Information with Valid Data
    Redirect To Kelola Akun Page
    Click Detail Akun Section
    Click Ubah Data Diri
    ${random_firstname}  ${random_lastname}  ${random_phone}   Generate Random Data For Detail Akun Data Diri
    Input First Name Personal Information               ${random_firstname}
    Input Last Name Personal Information                ${random_lastname}
    Input Phone Number Personal Information             ${random_phone}
    Click Simpan
    Verify Succesfull Change Personal Information With Valid Data

User Get Error Detail Akun With Empty First Name
    [Documentation]                 User Get Error Detail Akun With Empty First Name
    Redirect To Kelola Akun Page
    Click Detail Akun Section
    Click Ubah Data Diri
    ${random_firstname}  ${random_lastname}  ${random_phone}  Generate Random Data For Detail Akun Data Diri
    Press Key Clear
    Input Last Name Personal Information                ${random_lastname}
    Input Phone Number Personal Information             ${random_phone}
    Click Simpan
    Verify First Name Required

User Successfull Change Personal Information with First Name And Last Name Apostrof
    [Documentation]                 User Successfull Change Personal Information with First Name And Last Name Apostrof
    Redirect To Kelola Akun Page
    Click Detail Akun Section
    Click Ubah Data Diri
    ${random_firstname}  ${random_lastname}  ${random_phone}  Generate Random Data For Detail Akun Data Diri
    Input First Name Personal Information               '${random_firstname}'
    Input Last Name Personal Information                '${random_lastname}'
    Input Phone Number Personal Information              ${random_phone}
    Click Simpan
    Verify Succesfull Change Personal Information With Valid Data

User Get Error Detail Akun With Phone Number Less Then 6 Numeric
    [Documentation]                 User Get Error Detail Akun With Phone Number Less Then 6 Numeric
    Redirect To Kelola Akun Page
    Click Detail Akun Section
    Click Ubah Data Diri
    ${random_firstname}  ${random_lastname}  ${random_phone}  Generate Random Data For Detail Akun Data Diri
    ${less_numeric__phone}      Generate Random String     2   [NUMBERS]
    Input First Name Personal Information               ${random_firstname}
    Input Last Name Personal Information                ${random_lastname}
    Input Phone Number Personal Information             ${less_numeric__phone}
    Click Simpan
    Verify Invalid Phone Number


*** Keywords ***
Register New User
    [Documentation]                 Register New User
    ${random_firstname}  ${random_lastname}  ${random_email}  ${random_pass}   Generate Random Data For Register
    Go To                           ${URL_REGISTER}
    Input Register Form             ${random_firstname}  ${random_lastname}  ${random_email}  ${random_pass}
    Sleep                           2
    Checklist Recaptcha In Register
    Click Button Daftar
    Wait Until Element Is Visible   ${accountBar_registerPage}    30
    Go To                           ${URL_LOGIN}
    [Return]                        ${random_email}                   ${random_pass}

Input Register Form
    [Documentation]                 Input register form
    [Arguments]                     ${random_firstname}  ${random_lastname}  ${random_email}  ${random_pass}
    Input First Name                ${random_firstname}
    Input Last Name                 ${random_lastname}
    RegisterPage.Input Email        ${random_email}
    RegisterPage.Input Password     ${random_pass}
    Set Suite Variable              ${FIRST_NAME}           ${random_firstname}
    Set Suite Variable              ${REGISTERED_EMAIL}     ${random_email}
    Set Suite Variable              ${LAST_NAME}            ${random_lastname}

Login With Registered Email
    [Documentation]                    Login With Registered Email
    ${registered_email}                ${registered_password}                   Register New User
    Wait Until Element Is Visible      ${fieldEmail_loginPage}
    Wait Until Element Is Visible      ${fieldPassword_loginPage}
    LoginPage.Input Email              ${registered_email}
    LoginPage.Input Password           ${registered_password}
    Click Button Sign In

Verify User Succesfully Re-Direct
    [Documentation]                    Verify User Succesfully Re-Direct
    Wait Until Element Is Visible      ${headerDetailAkun_DetailAkunDataDiriPage}
    Wait Until Element Contains        ${headerDetailAkun_DetailAkunDataDiriPage}   Detail Akun     20
    ${curr_url}                        Get Location
    Location Should Contain            ${URL_DETAIL_AKUN}
    Wait Until Element Contains        ${linkDetailAkun_DetailAkunDataDiriPage}     Detail Akun     20
    Wait Until Element Contains        ${tabDataDiri_DetailAkunDataDiriPage}        Data Diri       20
    Wait Until Element Contains        ${tabAlamat_DetailAkunDataDiriPage}          Alamat          20
    Wait Until Element Contains        ${tabUbahSandi_DetailAkunDataDiriPage}       Ubah Sandi      20

Verify Element In Detail Akun Page
    [Documentation]                    Verify Element In Detail Akun Page
    Wait Until Element Is Visible      ${tabDataDiri_DetailAkunDataDiriPage}
    Wait Until Element Is Visible      ${tabAlamat_DetailAkunDataDiriPage}
    Wait Until Element Is Visible      ${tabUbahSandi_DetailAkunDataDiriPage}
    Wait Until Element Is Visible      ${buttonUbahDataDiri_DetailAkunDataDiriPage}
    Wait Until Element Contains        ${tabDataDiri_DetailAkunDataDiriPage}        Data Diri       20
    Wait Until Element Contains        ${tabAlamat_DetailAkunDataDiriPage}          Alamat          20
    Wait Until Element Contains        ${tabUbahSandi_DetailAkunDataDiriPage}       Ubah Sandi      20

Verify Element In Data Diri Form
    [Documentation]                    Verify Element In Data Diri Form
    Field Should Visible
    Button Should Visible And Enabled
    Element Should Be Enabled          ${radioButtonJenisKelamin_DetailAkunDataDiriPage}
    Element Should Be Visible          ${radioButtonJenisKelamin_DetailAkunDataDiriPage}    20
    Combo Box Should Visible And Enabled

Button Should Visible And Enabled
    [Documentation]                   Button Should Visible And Enabled
    Element Should Be Enabled         ${buttonSimpan_DetailAkunDataDiriPage}
    Element Should Be Enabled         ${buttonBatal_DetailAkunDataDiriPage}
    Element Should Be Visible         ${buttonSimpan_DetailAkunDataDiriPage}    20
    Element Should Be Visible         ${buttonBatal_DetailAkunDataDiriPage}     20

Combo Box Should Visible And Enabled
    [Documentation]                   Combo Box Should Visible And Enabled
    Element Should Be Enabled         ${comboBoxTanggalLahir_DetailAkunDataDiriPage}
    Element Should Be Enabled         ${comboBoxNegara_DetailAkunDataDiriPage}
    Element Should Be Visible         ${comboBoxTanggalLahir_DetailAkunDataDiriPage}    20
    Element Should Be Visible         ${comboBoxNegara_DetailAkunDataDiriPage}          20

Field Should Visible
    [Documentation]                   Field Should Visible
    Element Should Be Visible         ${fieldNamaDepan_DetailAkunDataDiriPage}      20
    Element Should Be Visible         ${fieldNamaBelakang_DetailAkunDataDiriPage}   20
    Element Should Be Visible         ${fieldNomorTelepon_DetailAkunDataDiriPage}   20
    Element Should Be Enabled         ${fieldNamaDepan_DetailAkunDataDiriPage}
    Element Should Be Enabled         ${fieldNamaBelakang_DetailAkunDataDiriPage}
    Element Should Be Enabled         ${fieldNomorTelepon_DetailAkunDataDiriPage}

Redirect To Kelola Akun Page
    [Documentation]                   Redirect To Kelola Akun Page
    Login With Registered Email
    Click Dropdown
    Click Kelola Akun
    Sleep                             5
    Switch Window                     new

Get Web Elements For Alert Success
    [Documentation]                                 Get Web Elements For Alert Success
    Wait Until Element Is Visible                   ${alertSuccessChangeData_DetailAkunDataDiriPage}
    ${web_elements}                                 Get Web Elements
    ...                                             ${alertSuccessChangeData_DetailAkunDataDiriPage}
    [Return]                                        ${web_elements}

Verify Succesfull Change Personal Information With Valid Data
    [Documentation]                                 Verify Succesfull Change Personal Information With Valid Data
    Wait Until Element Is Visible                   ${headerDataDiri_DetailAkunDataDiriPage}
    ${web_elements}                                 Get Web Elements For Alert Success
    Wait Until Element Contains                     ${web_elements}        Berhasil mengubah data diri Anda!

Get Web Elements For Alert
    [Documentation]                                 Get Web Elements For Alert
    Wait Until Element Is Visible                   ${alertChangeData_DetailAkunDataDiriPage}
    ${web_elements}                                 Get Web Elements
    ...                                             ${alertChangeData_DetailAkunDataDiriPage}
    [Return]                                        ${web_elements}

Verify First Name Required
    [Documentation]                                 Verify First Name Required
    ${web_elements}                                 Get Web Elements For Alert
    Wait Until Element Contains                     ${web_elements}             Nama depan harus diisi

Press Key Clear
    [Documentation]                                 Press Key Clear
    Wait And Click Element                          ${fieldNamaDepan_DetailAkunDataDiriPage}
    Press Keys                                      ${fieldNamaDepan_DetailAkunDataDiriPage}
    ...                                             CTRL+a+BACKSPACE

Verify Invalid Phone Number
    [Documentation]                          Verify Invalid Password
    ${web_elements}                          Get Web Elements For Alert
    Wait Until Element Contains              ${web_elements}
    ...                                      Masukkan minimal 6 digit nomor telepon yang valid.

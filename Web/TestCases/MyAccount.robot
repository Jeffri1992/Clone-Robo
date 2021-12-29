*** Settings ***
Documentation    Testcases for MyAccount
Resource         ../Libraries/CommonFunction.robot
Resource         PageObjects/MyAccountPage/MyAccountPage.robot
Resource         PageObjects/LoginPage/LoginPage.robot
Resource         PageObjects/RegisterPage/RegisterPage.robot
Resource         ../DataFactory/Register.robot
Variables        ../Resource/Account.yaml
Test Setup       Start Browser                      https://account.kompas.id/login
Test Teardown    Stop Browser
Force Tags       Squad-E


*** Variables ***
${URL_REGISTER}       https://account.kompas.cloud/register
${URL_LOGIN}          https://account.kompas.cloud/login
${URL_KELOLA_AKUN}    https://account.kompas.cloud/manage-account/my-account


*** Test Cases ***
User Succesfully Re-Direct To Kelola Akun Page
    [Documentation]                 User Succesfully Re-Direct To Kelola Akun Page
    [Tags]                          test1
    Login With Registered Email
    Click Dropdown
    Click Kelola Akun
    Sleep                   5
    Switch Window           new
    Verify User Succesfully Re-Direct

User Succesfully View Category Dropdown
    [Documentation]                 User Succesfully View Category Dropdown
    Login With Registered Email
    Click Dropdown
    Verify Category Dropdown List

User Succesfully View Ringkasan Profile Non-Membership
    [Documentation]                 User Succesfully View Ringkasan Profile Non-Membership
    Login With Registered Email
    Click Dropdown
    Click Kelola Akun
    Sleep                   5
    Switch Window           new
    Verify Ringkasan Profile Non-Membership

User Succesfully View Ringkasan Profile Membership < 7 Days
    [Documentation]                 User Succesfully View Ringkasan Profile Membership < 7 Days
    LoginPage.Input Email              ${membership.seminggu.email}
    LoginPage.Input Password           ${membership.seminggu.password}
    Click Button Sign In
    Click Dropdown
    Click Kelola Akun
    Sleep                   5
    Switch Window           new
    Verify Ringkasan Profile Membership 7 Day Again

User Succesfully View Ringkasan Profile Membership Expired
    [Documentation]                    User Succesfully View Ringkasan Profile Membership Expired
    LoginPage.Input Email              ${membership.expired.email}
    LoginPage.Input Password           ${membership.expire.password}
    Click Button Sign In
    Click Dropdown
    Click Kelola Akun
    Sleep                   5
    Switch Window           new
    Verify Ringkasan Profile Membership Expired

User Succesfully View Ringkasan Profile Membership Karyawan Kompas
    [Documentation]                    User Succesfully View Ringkasan Profile Membership Karyawan Kompas
    LoginPage.Input Email              ${membership.karyawan.email}
    LoginPage.Input Password           ${membership.karyawan.password}
    Click Button Sign In
    Click Dropdown
    Click Kelola Akun
    Sleep                   5
    Switch Window           new
    Verify Ringkasan Profile Membership Karyawan Kompas

User Succesfully View Ringkasan Profile Membership Atlit
    [Documentation]                    User Succesfully View Ringkasan Profile Membership Atlit
    LoginPage.Input Email              ${membership.atlit.email}
    LoginPage.Input Password           ${membership.atlit.password}
    Click Button Sign In
    Click Dropdown
    Click Kelola Akun
    Sleep                   5
    Switch Window           new
    Verify Ringkasan Profile Membership Atlit


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

Verify User Succesfully Re-Direct
    [Documentation]                    Verify User Succesfully Re-Direct
    Wait Until Element Is Visible      ${buttonPerbaruiLangganan_myAccountPage}
    ${curr_url}                        Get Location
    Location Should Contain            ${URL_KELOLA_AKUN}
    Wait Until Element Contains        ${sectionPromosi_myAccountPage}          Promosi

Verify Category Dropdown List
    [Documentation]                    Verify Category Dropdown List
    Wait Until Element Is Visible      ${buttonPerbaruiLangganan_myAccountPage}
    Wait Until Element Contains        ${dropDownKelolaAkun_myAccountPage}    Kelola Akun
    Wait Until Element Contains        ${dropDownTransaksi_myAccountPage}     Transaksi
    Wait Until Element Contains        ${dropDownTanyaJawab_myAccountPage}    Tanya Jawab
    Wait Until Element Contains        ${dropDownKeluar_myAccountPage}        Keluar

Verify Ringkasan Profile Non-Membership
    [Documentation]                    Verify Ringkasan Profile Non-Membership
    Wait Until Element Is Visible      ${ringkasanProfile_myAccountPage}
    Wait Until Element Contains        ${ringkasanProfile_myAccountPage}    ${FIRST_NAME} ${LAST_NAME}
    Wait Until Element Is Visible      ${buttonPerbaruiLangganan_myAccountPage}
    Wait Until Element Contains        ${ringkasanProfile_myAccountPage}    Tidak Berlangganan

Verify Ringkasan Profile Membership 7 Day Again
    [Documentation]                    Verify Ringkasan Profile Membership 7 Day Again
    Wait Until Element Is Visible      ${ringkasanProfile_myAccountPage}
    Wait Until Element Contains        ${ringkasanProfile_myAccountPage}    Akunkompasid13
    Wait Until Element Is Visible      ${buttonPerbaruiLangganan_myAccountPage}
    Wait Until Element Contains        ${ringkasanProfile_myAccountPage}    Aktif Berlangganan      20
    Wait Until Element Contains        ${ringkasanProfile_myAccountPage}    Berakhir 7 hari lagi    20

Verify Ringkasan Profile Membership Expired
    [Documentation]                    Verify Ringkasan Profile Membership Expired
    Wait Until Element Is Visible      ${ringkasanProfile_myAccountPage}
    Wait Until Element Contains        ${ringkasanProfile_myAccountPage}    Akunkompasid
    Wait Until Element Is Visible      ${buttonPerbaruiLangganan_myAccountPage}
    Wait Until Element Contains        ${ringkasanProfile_myAccountPage}    Tidak Berlangganan

Verify Ringkasan Profile Membership Karyawan Kompas
    [Documentation]                    Verify Ringkasan Profile Membership Expired
    Wait Until Element Is Visible      ${ringkasanProfile_myAccountPage}
    Wait Until Element Contains        ${ringkasanProfile_myAccountPage}    Akunkompasid17
    Wait Until Element Contains        ${ringkasanProfile_myAccountPage}    Aktif Berlangganan      20
    Wait Until Element Contains        ${ringkasanProfile_myAccountPage}    Karyawan - Akses Tanpa Batas    20

Verify Ringkasan Profile Membership Atlit
    [Documentation]                    Verify Ringkasan Profile Membership Atlit
    Wait Until Element Is Visible      ${ringkasanProfile_myAccountPage}
    Wait Until Element Contains        ${ringkasanProfile_myAccountPage}    Akunkompasid16
    Wait Until Element Contains        ${ringkasanProfile_myAccountPage}    Aktif Berlangganan      20
    Wait Until Element Contains        ${ringkasanProfile_myAccountPage}    Akses Seumur Hidup      20

Get And Remove String
    [Documentation]                    Get And Remove String
    Wait Until Element Is Visible      ${ringkasanProfile_myAccountPage}
    ${string_email_value}              Get Text        ${ringkasanTanggalAktif_myAccountPage}
    ${string_email}                    Split String     ${string_email_value}         -
    ${tanggal_awal}                    Set Variable      ${string_email [0]}
    ${tanggal_akhir}                   Set Variable      ${string_email [1]}
    ${tanggal_awal_replace}            Remove String   ${tanggal_awal}   ${SPACE}
    ${tanggal_akhir_replace}           Remove String   ${tanggal_akhir}  ${SPACE}
    [Return]                           ${tanggal_awal_replace} ${tanggal_akhir_replace}

Verify Ringkasan Profile Membership Sebulan
    [Documentation]              Verify Ringkasan Profile Membership Sebulan
    ${converted_tanggal_awal}    Convert Date    ${tanggal_awal_replace}
    ...                          date_format=%d%b%Y     result_format=%Y-%m-%d     exclude_millis=True
    ${converted_tanggal_akhir}   Convert Date    ${tanggal_akhir_replace}
    ...                          date_format=%d%b%Y     result_format=%Y-%m-%d     exclude_millis=True
    ${diffrence_in_days}         Subtract Date From Date    ${converted_tanggal_akhir}
    ...                          ${converted_tanggal_awal}  verbose
    @{total_days}                Split String    ${diffrence_in_days}
    ${final_days}                Set Variable    ${total_days[0]}
    Should Be True               ${final_days} >= 30

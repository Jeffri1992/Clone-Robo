*** Settings ***
Documentation    Testcases for Detail Akun UbahSandi
Resource         ../Libraries/CommonFunction.robot
Resource         PageObjects/DetailAkunUbahSandiPage/DetailAkunUbahSandiPage.robot
Resource         PageObjects/RegisterPage/RegisterPage.robot
Resource         ../DataFactory/Register.robot
Resource         ../DataFactory/DetailAkunUbahSandi.robot
Variables        ../Resource/Account.yaml
Test Setup       Start Browser                      https://account.kompas.cloud/login
Test Teardown    Stop Browser
Force Tags       Squad-E


*** Variables ***
${URL_REGISTER}       https://account.kompas.cloud/register
${URL_UBAH_SANDI}     https://account.kompas.cloud/manage-account/account-detail/reset-password


*** Test Cases ***
User Successfull View Element In Ubah Sandi Form Page
    [Documentation]                 User Successfull View Element In Ubah Sandi Form Page
    Redirect To Ubah Sandi Page
    Verify Element In Ubah Sandi Form

User Successfull Change Password With Medium Password
    [Documentation]                 User Successfull Change Password With Medium Password
    [Tags]                          nuxt-oauth2-kompasid-dev
    Redirect To Ubah Sandi Page
    ${random_pass_new}        Generate Random Data For Detail Akun Ubah Sandi
    DetailAkunUbahSandiPage.Input Current Password                      ${PASSWORD}
    DetailAkunUbahSandiPage.Input New Password                          ${random_pass_new}
    DetailAkunUbahSandiPage.Input Confirmation Password                 ${random_pass_new}
    DetailAkunUbahSandiPage.Click Simpan
    Verify Succesfull Change Password With Valid Password

User Successfull Change Password With Strong Password
    [Documentation]                 User Successfull Change Password With Strong Password
    [Tags]                          nuxt-oauth2-kompasid-dev
    Redirect To Ubah Sandi Page
    ${random_pass_new}        Generate Random Data For Detail Akun Ubah Sandi   pass_spc_chars=${True}
    DetailAkunUbahSandiPage.Input Current Password                      ${PASSWORD}
    DetailAkunUbahSandiPage.Input New Password                          ${random_pass_new}
    DetailAkunUbahSandiPage.Input Confirmation Password                 ${random_pass_new}
    DetailAkunUbahSandiPage.Click Simpan
    Verify Succesfull Change Password With Valid Password

User Get Error Ubah Sandi With Empty Current Password
    [Documentation]                 User Get Error Ubah Sandi With Empty Current Password
    [Tags]                          nuxt-oauth2-kompasid-dev
    Redirect To Ubah Sandi Page
    ${random_pass_new}        Generate Random Data For Detail Akun Ubah Sandi   pass_spc_chars=${True}
    DetailAkunUbahSandiPage.Input Current Password                      ${EMPTY}
    DetailAkunUbahSandiPage.Input New Password                          ${random_pass_new}
    DetailAkunUbahSandiPage.Input Confirmation Password                 ${random_pass_new}
    DetailAkunUbahSandiPage.Click Simpan
    Verify Current Password Required

User Get Error Ubah Sandi With Empty New Password
    [Documentation]                 User Get Error Ubah Sandi With Empty New Password
    [Tags]                          nuxt-oauth2-kompasid-dev
    Redirect To Ubah Sandi Page
    ${random_pass_new}        Generate Random Data For Detail Akun Ubah Sandi   pass_spc_chars=${True}
    DetailAkunUbahSandiPage.Input Current Password                      ${PASSWORD}
    DetailAkunUbahSandiPage.Input New Password                          ${EMPTY}
    DetailAkunUbahSandiPage.Input Confirmation Password                 ${random_pass_new}
    DetailAkunUbahSandiPage.Click Simpan
    Verify New Password Required

User Get Error Ubah Sandi With Empty Confirm Password
    [Documentation]                 User Get Error Ubah Sandi With Empty New Password
    Redirect To Ubah Sandi Page
    ${random_pass_new}        Generate Random Data For Detail Akun Ubah Sandi   pass_spc_chars=${True}
    DetailAkunUbahSandiPage.Input Current Password                      ${PASSWORD}
    DetailAkunUbahSandiPage.Input New Password                          ${random_pass_new}
    DetailAkunUbahSandiPage.Input Confirmation Password                 ${EMPTY}
    DetailAkunUbahSandiPage.Click Simpan
    Verify New Password Required

User Get Error Ubah Sandi With All Empty
    [Documentation]                 User Get Error Ubah Sandi With All Empty
    [Tags]                          nuxt-oauth2-kompasid-dev
    Redirect To Ubah Sandi Page
    ${random_pass_new}        Generate Random Data For Detail Akun Ubah Sandi   pass_spc_chars=${True}
    DetailAkunUbahSandiPage.Input Current Password                      ${EMPTY}
    DetailAkunUbahSandiPage.Input New Password                          ${EMPTY}
    DetailAkunUbahSandiPage.Input Confirmation Password                 ${EMPTY}
    DetailAkunUbahSandiPage.Click Simpan
    Verify All Field Required

User Get Error Ubah Sandi With Mismatch Current Password
    [Documentation]                 User Get Error Ubah Sandi With Mismatch Current Password
    Redirect To Ubah Sandi Page
    ${random_pass_new}        Generate Random Data For Detail Akun Ubah Sandi   pass_spc_chars=${True}
    DetailAkunUbahSandiPage.Input Current Password                      tgf'${PASSWORD}'
    DetailAkunUbahSandiPage.Input New Password                          ${random_pass_new}
    DetailAkunUbahSandiPage.Input Confirmation Password                 ${random_pass_new}
    DetailAkunUbahSandiPage.Click Simpan
    Verify Mismatch Current Password

User Get Error Ubah Sandi With Mismatch New Password
    [Documentation]                 User Get Error Ubah Sandi With Mismatch New Password
    Redirect To Ubah Sandi Page
    ${random_pass_new}        Generate Random Data For Detail Akun Ubah Sandi   pass_spc_chars=${True}
    DetailAkunUbahSandiPage.Input Current Password                      ${PASSWORD}
    DetailAkunUbahSandiPage.Input New Password                          ght'${random_pass_new}^^
    DetailAkunUbahSandiPage.Input Confirmation Password                 ${random_pass_new}
    DetailAkunUbahSandiPage.Click Simpan
    Verify Mismatch New Password And Confirm Password

User Get Error Ubah Sandi With Mismatch Confirm Password
    [Documentation]                 User Get Error Ubah Sandi With Mismatch Confirm Password
    Redirect To Ubah Sandi Page
    ${random_pass_new}        Generate Random Data For Detail Akun Ubah Sandi   pass_spc_chars=${True}
    DetailAkunUbahSandiPage.Input Current Password                      ${PASSWORD}
    DetailAkunUbahSandiPage.Input New Password                          ${random_pass_new}
    DetailAkunUbahSandiPage.Input Confirmation Password                 ght'${random_pass_new}
    DetailAkunUbahSandiPage.Click Simpan
    Verify Mismatch New Password And Confirm Password

User Get Error Ubah Sandi With New Password Less Then 6 Digit
    [Documentation]                 User Get Error Ubah Sandi With New Password Less Then 6 Digit
    Redirect To Ubah Sandi Page
    ${random_pass_new}        Generate Random Data For Detail Akun Ubah Sandi
    ${less_char_pass}         Password    length=4    lower_case=${true}
    DetailAkunUbahSandiPage.Input Current Password                      ${PASSWORD}
    DetailAkunUbahSandiPage.Input New Password                          ${less_char_pass}
    DetailAkunUbahSandiPage.Input Confirmation Password                 ${random_pass_new}
    DetailAkunUbahSandiPage.Click Simpan
    Verify Less Char Then 6 In New Password

User Get Error Ubah Sandi With Confirm Password Less Then 6 Digit
    [Documentation]                 User Get Error Ubah Sandi With Confirm Password Less Then 6 Digit
    Redirect To Ubah Sandi Page
    ${random_pass_new}        Generate Random Data For Detail Akun Ubah Sandi
    ${less_char_pass}         Password    length=4    lower_case=${true}
    DetailAkunUbahSandiPage.Input Current Password                      ${PASSWORD}
    DetailAkunUbahSandiPage.Input New Password                          ${random_pass_new}
    DetailAkunUbahSandiPage.Input Confirmation Password                 ${less_char_pass}
    DetailAkunUbahSandiPage.Click Simpan
    Verify Less Char Then 6 In Confirm Password

User Get Error Ubah Sandi With New Password Only Lower Case
    [Documentation]                 User Get Error Ubah Sandi With New Password Only Lower Case
    Redirect To Ubah Sandi Page
    ${random_pass_new}        Generate Random Data For Detail Akun Ubah Sandi
    ${lower_char_pass}        Password    upper_case=${false}  lower_case=${true}
    ...                       special_chars=${false}  digits=${false}
    DetailAkunUbahSandiPage.Input Current Password                      ${PASSWORD}
    DetailAkunUbahSandiPage.Input New Password                          ${lower_char_pass}
    DetailAkunUbahSandiPage.Input Confirmation Password                 ${random_pass_new}
    DetailAkunUbahSandiPage.Click Simpan
    Verify Less Char Then 6 In New Password

User Get Error Ubah Sandi With New Password Only Upper Case
    [Documentation]                 User Get Error Ubah Sandi With New Password Only Upper Case
    Redirect To Ubah Sandi Page
    ${random_pass_new}        Generate Random Data For Detail Akun Ubah Sandi
    ${upper_char_pass}        Password    upper_case=${true}  lower_case=${false}
    ...                       special_chars=${false}  digits=${false}
    DetailAkunUbahSandiPage.Input Current Password                      ${PASSWORD}
    DetailAkunUbahSandiPage.Input New Password                          ${upper_char_pass}
    DetailAkunUbahSandiPage.Input Confirmation Password                 ${random_pass_new}
    DetailAkunUbahSandiPage.Click Simpan
    Verify Less Char Then 6 In New Password

User Get Error Ubah Sandi With New Password Only Numeric
    [Documentation]                 User Get Error Ubah Sandi With New Password Only Numeric
    Redirect To Ubah Sandi Page
    ${random_pass_new}          Generate Random Data For Detail Akun Ubah Sandi
    ${numeric_char_pass}        Password    upper_case=${false}  lower_case=${false}
    ...                         special_chars=${false}  digits=${true}
    DetailAkunUbahSandiPage.Input Current Password                      ${PASSWORD}
    DetailAkunUbahSandiPage.Input New Password                          ${numeric_char_pass}
    DetailAkunUbahSandiPage.Input Confirmation Password                 ${random_pass_new}
    DetailAkunUbahSandiPage.Click Simpan
    Verify Less Char Then 6 In New Password

User Get Error Ubah Sandi With New Password Only Special Char
    [Documentation]                 User Get Error Ubah Sandi With New Password Only Special Char
    Redirect To Ubah Sandi Page
    ${random_pass_new}          Generate Random Data For Detail Akun Ubah Sandi
    ${spesial_char_pass}        Password    upper_case=${false}  lower_case=${false}
    ...                         special_chars=${true}  digits=${false}
    DetailAkunUbahSandiPage.Input Current Password                      ${PASSWORD}
    DetailAkunUbahSandiPage.Input New Password                          ${spesial_char_pass}
    DetailAkunUbahSandiPage.Input Confirmation Password                 ${random_pass_new}
    DetailAkunUbahSandiPage.Click Simpan
    Verify Less Char Then 6 In New Password

User Get Error Ubah Sandi With New Password Lower And Upper Case
    [Documentation]                 User Get Error Ubah Sandi With New Password Lower And Upper Case
    Redirect To Ubah Sandi Page
    ${random_pass_new}              Generate Random Data For Detail Akun Ubah Sandi
    ${upp_and_low_char_pass}        Password    upper_case=${true}  lower_case=${true}
    ...                             special_chars=${false}  digits=${false}
    DetailAkunUbahSandiPage.Input Current Password                      ${PASSWORD}
    DetailAkunUbahSandiPage.Input New Password                          ${upp_and_low_char_pass}
    DetailAkunUbahSandiPage.Input Confirmation Password                 ${random_pass_new}
    DetailAkunUbahSandiPage.Click Simpan
    Verify Less Char Then 6 In New Password

User Get Error Ubah Sandi With Confirm Password Only Lower Case
    [Documentation]                 User Get Error Ubah Sandi With Confirm Password Only Lower Case
    Redirect To Ubah Sandi Page
    ${random_pass_new}              Generate Random Data For Detail Akun Ubah Sandi
    ${low_char_pass}                Password    upper_case=${false}  lower_case=${true}
    ...                             special_chars=${false}  digits=${false}
    DetailAkunUbahSandiPage.Input Current Password                      ${PASSWORD}
    DetailAkunUbahSandiPage.Input New Password                          ${random_pass_new}
    DetailAkunUbahSandiPage.Input Confirmation Password                 ${low_char_pass}
    DetailAkunUbahSandiPage.Click Simpan
    Verify Less Char Then 6 In Confirm Password

User Get Error Ubah Sandi With Confirm Password Only Upper Case
    [Documentation]                 User Get Error Ubah Sandi With Confirm Password Only Upper Case
    Redirect To Ubah Sandi Page
    ${random_pass_new}              Generate Random Data For Detail Akun Ubah Sandi
    ${upp_char_pass}                Password    upper_case=${true}  lower_case=${false}
    ...                             special_chars=${false}  digits=${false}
    DetailAkunUbahSandiPage.Input Current Password                      ${PASSWORD}
    DetailAkunUbahSandiPage.Input New Password                          ${random_pass_new}
    DetailAkunUbahSandiPage.Input Confirmation Password                 ${upp_char_pass}
    DetailAkunUbahSandiPage.Click Simpan
    Verify Less Char Then 6 In Confirm Password

User Get Error Ubah Sandi With Confirm Password Only Numeric
    [Documentation]                 User Get Error Ubah Sandi With Confirm Password Only Numeric
    Redirect To Ubah Sandi Page
    ${random_pass_new}              Generate Random Data For Detail Akun Ubah Sandi
    ${number_char_pass}             Password    upper_case=${false}  lower_case=${false}
    ...                             special_chars=${false}  digits=${true}
    DetailAkunUbahSandiPage.Input Current Password                      ${PASSWORD}
    DetailAkunUbahSandiPage.Input New Password                          ${random_pass_new}
    DetailAkunUbahSandiPage.Input Confirmation Password                 ${number_char_pass}
    DetailAkunUbahSandiPage.Click Simpan
    Verify Less Char Then 6 In Confirm Password

User Get Error Ubah Sandi With Confirm Password Only Special Char
    [Documentation]                 User Get Error Ubah Sandi With Confirm Password Only Special Char
    Redirect To Ubah Sandi Page
    ${random_pass_new}              Generate Random Data For Detail Akun Ubah Sandi
    ${special_char_pass}            Password    upper_case=${false}  lower_case=${false}
    ...                             special_chars=${true}  digits=${false}
    DetailAkunUbahSandiPage.Input Current Password                      ${PASSWORD}
    DetailAkunUbahSandiPage.Input New Password                          ${random_pass_new}
    DetailAkunUbahSandiPage.Input Confirmation Password                 ${special_char_pass}
    DetailAkunUbahSandiPage.Click Simpan
    Verify Less Char Then 6 In Confirm Password

User Get Error Ubah Sandi With Confirm Password Lower And Upper Case
    [Documentation]                 User Get Error Ubah Sandi With Confirm Password Only Special Char
    Redirect To Ubah Sandi Page
    ${random_pass_new}              Generate Random Data For Detail Akun Ubah Sandi
    ${upp_and_low_char_pass}        Password    upper_case=${true}  lower_case=${true}
    ...                             special_chars=${false}  digits=${false}
    DetailAkunUbahSandiPage.Input Current Password                      ${PASSWORD}
    DetailAkunUbahSandiPage.Input New Password                          ${random_pass_new}
    DetailAkunUbahSandiPage.Input Confirmation Password                 ${upp_and_low_char_pass}
    DetailAkunUbahSandiPage.Click Simpan
    Verify Less Char Then 6 In Confirm Password


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
    Set Suite Variable              ${PASSWORD}             ${random_pass}

Verify Element In Ubah Sandi Form
    [Documentation]                    Verify Element In Ubah Sandi Form
    Wait Until Element Is Visible      ${headerUbahSandi_DetailAkunUbahSandiPage}           20
    Wait Until Element Contains        ${headerUbahSandi_DetailAkunUbahSandiPage}       Ubah sandi      20
    Element Should Be Visible          ${fieldKataSandiSaatIni_DetailAkunUbahSandiPage}     20
    Element Should Be Enabled          ${fieldKataSandiSaatIni_DetailAkunUbahSandiPage}
    Element Should Be Visible          ${fieldKataSandiBaru_DetailAkunUbahSandiPage}        20
    Element Should Be Enabled          ${fieldKataSandiBaru_DetailAkunUbahSandiPage}
    Element Should Be Visible          ${fieldKonfirmasiSandi_DetailAkunUbahSandiPage}      20
    Element Should Be Enabled          ${fieldKonfirmasiSandi_DetailAkunUbahSandiPage}

Redirect To Ubah Sandi Page
    [Documentation]                   Redirect To Ubah Sandi Page
    Register New User
    Go To                              ${URL_UBAH_SANDI}

Get Web Elements For Alert Success
    [Documentation]                                 Get Web Elements For Alert Success
    Wait Until Element Is Visible                   ${alertSuccessChangeData_DetailAkunUbahSandiPage}
    ${web_elements}                                 Get Web Elements
    ...                                             ${alertSuccessChangeData_DetailAkunUbahSandiPage}
    [Return]                                        ${web_elements}

Verify Succesfull Change Password With Valid Password
    [Documentation]                                 Verify Succesfull Change Password With Valid Password
    Wait Until Element Is Visible                   ${alertSuccessChangeData_DetailAkunUbahSandiPage}
    ${web_elements}                                 Get Web Elements For Alert Success
    Wait Until Element Contains                     ${web_elements}        Berhasil mengubah kata sandi Anda!

Get Web Elements For Alert
    [Documentation]                                 Get Web Elements For Alert
    Wait Until Element Is Visible                   ${alertChangeData_DetailAkunUbahSandiPage}
    ${web_elements}                                 Get Web Elements
    ...                                             ${alertChangeData_DetailAkunUbahSandiPage}
    [Return]                                        ${web_elements}

Verify Current Password Required
    [Documentation]                                 Verify Current Password Required
    ${web_elements}                                 Get Web Elements For Alert
    Wait Until Element Contains                     ${web_elements}             Kata sandi saat ini harus diisi.

Verify New Password Required
    [Documentation]                                 Verify New Password Required
    ${web_elements}                                 Get Web Elements For Alert
    Wait Until Element Contains                     ${web_elements}             Kata sandi baru harus diisi.

Verify All Field Required
    [Documentation]                                 Verify New Password Required
    ${web_elements}                                 Get Web Elements For Alert
    Wait Until Element Contains                     ${web_elements[0]}         Kata sandi saat ini harus diisi.
    Wait Until Element Contains                     ${web_elements[1]}         Kata sandi baru harus diisi.
    Wait Until Element Contains                     ${web_elements[2]}         Kata sandi baru harus diisi.

Verify Mismatch Current Password
    [Documentation]                                 Verify Mismatch Current Password
    ${web_elements}                                 Get Web Elements For Alert
    Wait Until Element Contains                     ${web_elements}
    ...                                             Kata sandi saat ini tidak sesuai. Periksa Kembali

Verify Mismatch New Password And Confirm Password
    [Documentation]                                 Verify Mismatch New Password And Confirm Password
    ${web_elements}                                 Get Web Elements For Alert
    Wait Until Element Contains                     ${web_elements}
    ...                 Konfirmasi kata sandi baru harus sama dengan kata sandi baru. Silakan periksa lagi.

Verify Less Char Then 6 In New Password
    [Documentation]                                 Verify Less Char Then 6 In New Password
    ${web_elements}                                 Get Web Elements For Alert
    Wait Until Element Contains                     ${web_elements}
    ...             Kata sandi lemah. Diwajibkan berisi minimal 6 karakter dengan kombinasi huruf dan angka.    20

Verify Less Char Then 6 In Confirm Password
    [Documentation]                                 Verify Less Char Then 6 In Confirm Passwordd
    ${web_elements}                                 Get Web Elements For Alert
    Wait Until Element Contains                     ${web_elements}
    ...             Konfirmasi kata sandi baru harus sama dengan kata sandi baru. Silakan periksa lagi.

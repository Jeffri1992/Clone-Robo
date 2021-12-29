*** Settings ***
Documentation    Testcases for DeviceSettings
Resource         ../Libraries/CommonFunction.robot
Resource         PageObjects/LoginPage/LoginPage.robot
Resource         PageObjects/RegisterPage/RegisterPage.robot
Resource         PageObjects/DeviceSettingsPage/DeviceSettingsPage.robot
Resource         ../DataFactory/Register.robot
Test Setup       Start Browser                      https://account.kompas.cloud/login
Test Teardown    Stop Browser
Force Tags       Squad-E


*** Variables ***
${URL_REGISTER}           https://account.kompas.cloud/register
${URL_DEVICE_SETTINGS}    https://account.kompas.cloud/manage-account/activity/device
${URL_LOGIN}              https://account.kompas.cloud/login
${URL_AFTER_LOGIN}        https://www.kompas.cloud/?status=sukses_login


*** Test Cases ***
User Succesfully Re-Direct To Device Settings Page
  [Documentation]                 User Succesfully Re-Direct To Device Settings Page
  Register New User
  Verify User Succesfully Re-Direct Device Settings

User Succesfully View Device Information After Login
  [Documentation]                 User Succesfully View Device Information After Login
  Register New User
  Verify User Device Information After Login

User Succesfully View Device Information With Multiple Login
  [Documentation]                   User Succesfully View Device Information With Multiple Login
  ${registered_email}               ${registered_password}                Register New User
  Go Back Than 1 Times              4
  Login More Than 1 Times Success   3            ${registered_email}       ${registered_password}
  Go To                             ${URL_DEVICE_SETTINGS}
  Verify User Device Information With Multiple Login

User Succesfully Revoke Their Own Device
  [Documentation]                 User Succesfully Revoke Their Own Device
  Register New User
  Click Delete Own Device
  Click Agree To Revoke Device
  Verify Succesfull Revoke Their Own Device

User Succesfully Revoke Another Device
  [Documentation]                   User Succesfully Revoke Another Device
  ${registered_email}               ${registered_password}                Register New User
  Go Back Than 1 Times              4
  Login More Than 1 Times Success   4            ${registered_email}       ${registered_password}
  Go To                             ${URL_DEVICE_SETTINGS}
  Click Delete Another Device
  Click Agree To Revoke Device
  Verify Succesfull Revoke Another Device

User Get Error After Login 6x (Have 5 device)
  [Documentation]                   User Get Error After Login 6x (Have 5 device)
  ${registered_email}               ${registered_password}                Register New User
  Go Back Than 1 Times              4
  Login More Than 1 Times Success   5            ${registered_email}       ${registered_password}
  Wait Until Element Is Visible     ${fieldEmail_loginPage}    30
  LoginPage.Input Email             ${registered_email}
  LoginPage.Input Password          ${registered_password}
  Click Button Sign In
  Verify Error After Login 6x (Have 5 Device)

User Get Error Revoke Device That Already Revoked
  [Documentation]                   User Get Error Revoke Device That Already Revoked
  ${registered_email}               ${registered_password}                Register New User
  Go Back Than 1 Times              4
  Login More Than 1 Times Success   3            ${registered_email}       ${registered_password}
  Go To                             ${URL_DEVICE_SETTINGS}
  Open New Tab With Same URL
  Verify Error Revoke Device That Already Revoked

User Succesfully Revoke In Fully Device Page
  [Documentation]                   User Succesfully Revoke In Fully Device Page
  [Tags]                            Test6
  ${registered_email}               ${registered_password}                Register New User
  Go Back Than 1 Times              4
  Login More Than 1 Times Success   5            ${registered_email}       ${registered_password}
  Wait Until Element Is Visible     ${fieldEmail_loginPage}    30
  LoginPage.Input Email             ${registered_email}
  LoginPage.Input Password          ${registered_password}
  Click Button Sign In
  Click Delete Device In Full Page
  Click Agree To Revoke Device
  Verify Succesfull Revoke In Fully Device Page


*** Keywords ***
Register New User
  [Documentation]                 Register New User
  ${random_firstname}  ${random_lastname}  ${random_email}  ${random_pass}   Generate Random Data For Register
  Go To                           ${URL_REGISTER}
  Input Register Form             ${random_firstname}  ${random_lastname}  ${random_email}  ${random_pass}
  Checklist Recaptcha In Register
  Click Button Daftar
  Wait Until Element Is Visible   ${accountBar_registerPage}    30
  Go To                           ${URL_DEVICE_SETTINGS}
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

Verify User Succesfully Re-Direct Device Settings
  [Documentation]                    Verify User Succesfully Re-Direct
  Wait Until Element Is Visible      ${headerAktivitas_deviceSettingsPage}
  Wait Until Element Contains        ${headerAktivitas_deviceSettingsPage}      Aktivitas
  Location Should Contain            ${URL_DEVICE_SETTINGS}
  Wait Until Element Contains        ${linkAturPerangkat_deviceSettingsPage}    Atur Perangkat
  Wait Until Element Contains        ${linkAksesAkun_deviceSettingsPage}        Akses Akun

Verify User Device Information After Login
  [Documentation]                    Verify User Device Information After Login
  Wait Until Element Is Visible      ${listPerangkat_deviceSettingsPage}
  Wait Until Element Contains        ${listPerangkat_deviceSettingsPage}        Perangkat ini

Verify User Device Information With Multiple Login
  [Documentation]                    Verify User Device Information With Multiple Login
  Wait Until Element Is Visible      ${tablePerangkat_deviceSetttingPage}
  Wait Until Element Contains        ${tablePerangkat_deviceSetttingPage}       Terakhir aktif
  ${web_elements}   ${count}         Get Web Elements For List Device
  Should Be True                     ${count} > 1

Get Web Elements For List Device
  [Documentation]                  Get Web Elements For List Device
  Wait Until Element Is Visible    ${listPerangkat_deviceSettingsPage}
  ${web_elements}                  Get Web Elements          ${listPerangkat_deviceSettingsPage}
  ${count}                         Get Element Count         ${listPerangkat_deviceSettingsPage}
  [Return]                         ${web_elements}           ${count}

Login More Than 1 Times Success
  [Documentation]                   Login More Than 1 Times Success (All Looping Login Need Go back To Login Form)
  [Arguments]                        ${times}                  ${email}        ${password}
  ${index}                           Set Variable              1
  FOR                                ${i}                      IN RANGE        1        ${times}
   EXIT FOR LOOP IF                  ${index} == ${times}
   Wait Until Element Is Visible     ${fieldEmail_loginPage}    30
   LoginPage.Input Email             ${email}
   LoginPage.Input Password          ${password}
   Click Button Sign In
   ${index}                          Evaluate                  ${index}+1
   Wait Until Element Is Visible     ${accountBar_registerPage}    30
   Go Back
   Wait Until Element Is Visible     ${fieldEmail_loginPage}    30
  END

Go Back Than 1 Times
  [Documentation]                       Go Back Than 1 Times
  [Arguments]                           ${times}
  ${index}                              Set Variable              1
  FOR                                   ${i}                      IN RANGE        1        ${times}
   EXIT FOR LOOP IF                     ${index} == ${times}
   Go Back
   ${index}                             Evaluate                  ${index}+1
  END
  Wait And Click Element                ${hyperLinkSilakanMasuk_registerPage}

Get Web Elements For Alert Succesfull Revoke
  [Documentation]                                 Get Web Elements For Alert Succesfull Revoke
  Wait Until Element Is Visible                   ${alertSuccessrRevokeOwn_deviceSettingsPage}
  ${web_elements}                                 Get Web Elements      ${alertSuccessrRevokeOwn_deviceSettingsPage}
  [Return]                                        ${web_elements}

Verify Succesfull Revoke Their Own Device
  [Documentation]                                 Verify Succesfull Revoke Their Own Device
  ${web_elements}                                 Get Web Elements For Alert Succesfull Revoke
  Wait Until Element Contains                     ${web_elements}    Anda telah keluar dari perangkat
  Location Should Contain                         ${URL_LOGIN}

Verify Succesfull Revoke Another Device
  [Documentation]                                 Verify Succesfull Revoke Another Device
  ${web_elements}                                 Get Web Elements For Alert Succesfull Revoke
  Wait Until Element Contains                     ${web_elements}    Anda telah keluar dari perangkat
  ${web_elements}   ${count}                      Get Web Elements For List Device
  Should Be True                                  ${count} == 3

Verify Error After Login 6x (Have 5 Device)
  [Documentation]                                Verify Error After Login 6x (Have 5 device)
  Wait Until Page Contains                       Penggunaan Perangkat Penuh Akun
  Location Should Contain                        device-list
  Page Should Contain                            Anda sudah aktif di 5 perangkat.

Get Web Elements For Alert Error Revoke
  [Documentation]                                 Get Web Elements For Alert Error Revoke
  Wait Until Element Is Visible                   ${alertSuccessrRevokeOthers_deviceSettingsPage}
  ${web_elements}                                 Get Web Elements      ${alertSuccessrRevokeOthers_deviceSettingsPage}
  [Return]                                        ${web_elements}

Verify Error Revoke Device That Already Revoked
  [Documentation]                                 Verify Error Revoke Device That Already Revoked
  ${web_elements}                                 Get Web Elements For Alert Error Revoke
  Wait Until Element Contains                     ${web_elements}    Perangkat telah dikeluarkan. Silakan pilih keluar

Open New Tab With Same URL
  [Documentation]                                 Open New Tab With Same URL
  Execute Javascript                              window.open('${URL_DEVICE_SETTINGS}');
  ${handles}                                      Get Window Handles
  Switch Window                                   ${handles}[1]
  Wait Until Element Is Visible                   ${listPerangkat_deviceSettingsPage}      20
  Click Delete Another Device
  Click Agree To Revoke Device
  Switch Window                                   ${handles}[0]
  Switch To Main Tab Not Current

Switch To Main Tab Not Current
  [Documentation]                                 Switch To Main Tab Not Current
  Wait Until Element Is Visible                   ${listPerangkat_deviceSettingsPage}      20
  Click Delete Another Device
  Click Agree To Revoke Device

Verify Succesfull Revoke In Fully Device Page
  [Documentation]                                 Verify Succesfull Revoke In Fully Device Page
  Wait Until Element Is Visible                   ${accountBar_registerPage}      20
  Location Should Contain                         ${URL_AFTER_LOGIN}

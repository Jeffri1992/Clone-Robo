*** Settings ***
Documentation                 My Account page
Variables    myAccount_locators.yaml


*** Keywords ***
Click Kelola Akun
    [Documentation]                  Click Kelola Akun
    Wait And Click Element           ${linkKelolaAkun_myAccountPage}

Click Dropdown
    [Documentation]                  Click Dropdown
    Wait And Click Element           ${headerProfile_myAccountPage}

*** Settings ***
Documentation                 1secmail page
Variables    1secmail_locators.yaml


*** Keywords ***
Input Email In Sec1Mail
    [Documentation]              Input Email In Forgot Password
    [Arguments]                  ${email}
    Wait And Input Text          ${fieldEmail_sec1MailPage}        ${email}

Select Domain In SecMail
    [Documentation]              Select Domain
    Select From List By Label    domain        @1secmail.com

Click Link Forgot Password
    [Documentation]              Click Link Forgot Password
    Wait And Click Element       ${linkInEmail_sec1MailPage}

Click Button Check In Secmail
    [Documentation]              Click Button Check In Secmail
    Wait And Click Element       ${buttonCheck_sec1MailPage}

Click Link Verifikasi
    [Documentation]              Click Link Verifikasi
    Scroll To Element            ${linkVerifikasi_sec1MailPage}
    Wait And Click Element       ${linkVerifikasi_sec1MailPage}

Go To SecMail
    [Documentation]              Go To 1secMail
    Go To                        https://www.1secmail.com/
    Wait Until Page Contains     1secMail

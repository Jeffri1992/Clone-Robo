*** Settings ***
Documentation    Verification page
Variables    verification_locators.yaml


*** Keywords ***
Input Host Name
    [Documentation]                  Input Host Name
    [Arguments]                      ${host_name}
    Wait Until Page Contains         1secMail
    Wait Until Element Is Visible    ${fieldHostname_verificationPage}
    Input Text                       ${fieldHostname_verificationPage}    ${host_name}

Select Domain
    [Documentation]                  Select Domain
    Select From List By Label        domain           @1secmail.com

Click Button Check
    [Documentation]                  Click Button Check
    Wait Until Element Is Visible    ${btnCheck_verificationPage}
    Wait And Click Element           ${btnCheck_verificationPage}

Click Mailbox
    [Documentation]                  Click Subject Email
    Wait And Click Element           ${linkMailbox_verificationPage}

Go To 1secMail
    [Documentation]                  Go To 1secMail
    Go To                            https://www.1secmail.com/

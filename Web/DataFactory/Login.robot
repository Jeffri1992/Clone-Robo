*** Settings ***
Documentation   Login


*** Variables ***
${HOST_NAME}                            testsdet.


*** Keywords ***
Generate Random Data For Login
    [Documentation]     Generate Data For Login
    ${random_lastname}    Generate Random String    12    chars=[LETTERS]
    ${email}              Email    domain=1secmail.com
    ${random_email}       Set Variable    ${HOST_NAME}${email}
    ${random_pass}   Password  length=10  upper_case=${true}
    ...                        lower_case=${true}  special_chars=${true}
    [Return]         ${random_email}   ${random_pass}

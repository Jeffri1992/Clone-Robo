*** Settings ***
Documentation   Register data


*** Variables ***
${HOST_NAME}                            testsdet


*** Keywords ***
Generate Random Data For Register
    [Documentation]     Generate Data For Register
    [Arguments]         ${pass_length}=8   ${pass_spc_chars}=${False}  ${valid_char}=${True}
    IF   ${valid_char}==${True}
         ${random_firstname}   First Name
         ${random_lastname}    Last Name
    ELSE
         ${random_firstname}   Generate Random String    12    chars=@#$^&*[NUMBERS]
         ${random_lastname}    Generate Random String    12    chars=@#$^&*[NUMBERS]
    END
    ${email}                 Email    domain=1secmail.com
    ${string}                Generate Random String    2    chars=[LETTERS]
    ${random_digit}          Generate Random String    1    123
    ${numbers}               Generate Random String    ${random_digit}    [NUMBERS]
    ${string_lower}          Convert To Lower Case     ${string}
    ${random_email}          Set Variable    ${HOST_NAME}${numbers}.${string_lower}${email}
    ${random_pass}           Password  length=${pass_length}  upper_case=${true}
    ...                      lower_case=${true}  special_chars=${pass_spc_chars}
    [Return]                 ${random_firstname}    ${random_lastname}
    ...                      ${random_email}   ${random_pass}

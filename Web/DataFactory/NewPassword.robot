*** Settings ***
Documentation   New Password


*** Keywords ***
Generate Random Password For New Password
    [Documentation]     Generate Random Password For New Password
    [Arguments]         ${pass_length}   ${upper_case}   ${lower_case}    ${digits}   ${special_chars}
    ${random_pass}      Password  length=${pass_length}        upper_case=${upper_case}
    ...                           lower_case=${lower_case}     digits=${digits}
    ...                           special_chars=${special_chars}
    [Return]            ${random_pass}

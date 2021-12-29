*** Settings ***
Documentation   Detail Akun Ubah Sandi Data


*** Keywords ***
Generate Random Data For Detail Akun Ubah Sandi
    [Documentation]     Generate Random Data For Detail Akun Ubah Sandi
    [Arguments]         ${pass_length}=8   ${pass_spc_chars}=${False}
    ${random_pass}      Password  length=${pass_length}  upper_case=${true}
    ...                 lower_case=${true}  special_chars=${pass_spc_chars}
    [Return]            ${random_pass}

*** Settings ***
Documentation   Detail Akun Data Diri Data


*** Keywords ***
Generate Random Data For Detail Akun Data Diri
    [Documentation]     Generate Random Data For Detail Akun Data Diri
    [Arguments]         ${phone_length}=6   ${valid_number}=${True}  ${valid_char}=${True}
    IF   ${valid_char}==${True}
         ${random_firstname}   First Name
         ${random_lastname}    Last Name
    ELSE
         ${random_firstname}   Generate Random String    12    chars=@#$^&*[NUMBERS]
         ${random_lastname}    Generate Random String    12    chars=@#$^&*[NUMBERS]
    END

    IF   ${valid_number}==${True}
         ${random_phone}   Phone Number
    ELSE
         ${random_phone}  Generate Random String    12   chars=@#$^&*[LETTERS]
    END

    IF   ${phone_length}>6
         ${random_phone}   Phone Number
    ELSE
         ${random_phone}  Generate Random String    6   [NUMBERS]
    END

    [Return]                 ${random_firstname}    ${random_lastname}
    ...                      ${random_phone}

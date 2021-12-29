*** Settings ***
Documentation                 Detail Akun Data Diri page
Variables    detailAkunDataDiri_locators.yaml


*** Keywords ***
Click Ubah Data Diri
    [Documentation]                  Click Ubah Data Diri
    Wait And Click Element           ${buttonUbahDataDiri_DetailAkunDataDiriPage}
    Wait Until Element Contains      ${headerDataDiri_DetailAkunDataDiriPage}   Data Diri   20
    Sleep   3

Click Lengkapi Data Diri
    [Documentation]                  Click Lengkapi Data Diri
    Wait And Click Element           ${buttonLengkapiDataDiri_DetailAkunDataDiriPage}

Click Tab Data Diri
    [Documentation]                  Click Tab Data Diri
    Wait And Click Element           ${tabDataDiri_DetailAkunDataDiriPage}

Click Detail Akun Section
    [Documentation]                  Click Detail Akun Section
    Wait And Click Element           ${linkDetailAkun_DetailAkunDataDiriPage}
    Sleep                            5

Input First Name Personal Information
    [Documentation]                  Input First Name Personal Information
    [Arguments]                      ${first_name}
    Wait Until Element Is Visible    ${fieldNamaDepan_DetailAkunDataDiriPage}
    Input Text                       ${fieldNamaDepan_DetailAkunDataDiriPage}    ${first_name}

Input Last Name Personal Information
    [Documentation]                  Input Last Name Personal Information
    [Arguments]                      ${last_name}
    Wait Until Element Is Visible    ${fieldNamaBelakang_DetailAkunDataDiriPage}
    Input Text                       ${fieldNamaBelakang_DetailAkunDataDiriPage}    ${last_name}

Input Phone Number Personal Information
    [Documentation]                   Input Phone Number Personal Information
    [Arguments]                      ${phone_number}
    Wait Until Element Is Visible    ${fieldNomorTelepon_DetailAkunDataDiriPage}
    Input Text                       ${fieldNomorTelepon_DetailAkunDataDiriPage}    ${phone_number}

Click Simpan
    [Documentation]                  Click Simpan
    Wait And Click Element           ${buttonSimpan_DetailAkunDataDiriPage}

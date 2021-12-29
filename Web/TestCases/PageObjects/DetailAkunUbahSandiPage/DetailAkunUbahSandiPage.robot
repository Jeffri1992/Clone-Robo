*** Settings ***
Documentation                 Detail Akun Ubah Sandi page
Variables    detailAkunUbahSandi_locators.yaml


*** Keywords ***
Click Tab Ubah Sandi
    [Documentation]                  Click Tab Data Diri
    Wait And Click Element           ${tabUbahSandi_DetailAkunUbahSandiPage}

Input Current Password
    [Documentation]                  Input Current Password
    [Arguments]                      ${curr_password}
    Wait Until Element Is Visible    ${fieldKataSandiSaatIni_DetailAkunUbahSandiPage}
    Input Text                       ${fieldKataSandiSaatIni_DetailAkunUbahSandiPage}    ${curr_password}

Input New Password
    [Documentation]                  Input New Password
    [Arguments]                      ${new_password}
    Wait Until Element Is Visible    ${fieldKataSandiBaru_DetailAkunUbahSandiPage}
    Input Text                       ${fieldKataSandiBaru_DetailAkunUbahSandiPage}    ${new_password}

Input Confirmation Password
    [Documentation]                  Input Confirmation Password
    [Arguments]                      ${confirm_password}
    Wait Until Element Is Visible    ${fieldKonfirmasiSandi_DetailAkunUbahSandiPage}
    Input Text                       ${fieldKonfirmasiSandi_DetailAkunUbahSandiPage}    ${confirm_password}

Click Simpan
    [Documentation]                  Click Simpan
    Wait And Click Element           ${buttonSimpan_DetailAkunUbahSandiPage}

Click Batal
    [Documentation]                  Click Batal
    Wait And Click Element           ${buttonBatal_DetailAkunUbahSandiPage}

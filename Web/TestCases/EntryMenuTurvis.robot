*** Settings ***
Documentation          Testcases for Login
Resource               ../Libraries/CommonFunction.robot
Resource               PageObjects/TurvisKompasPage/EntryMenuTurvisPage.robot
Suite Setup             Start Browser                  https://www.kompas.id/
Suite Teardown          Stop Browser
Force Tags            Squad-T


*** Variables ***
${URL_AFTER_LOGIN}          https://www.kompas.cloud/?status=sukses_login&status_login=login


*** Test Case ***
User Entry Menu Turvis
    [Documentation]             User Entry Menu Turvis
    Entry Menu Turvis
    Verify Element In Turvis Page


*** Keywords ***
Verify Element In Turvis Page
    [Documentation]            Verify Element In Turvis Page
    Wait Until Page Contains         Tutur Visual
    Wait Until Element Is Visible    ${text_TurvisPage}
    ${current_Url}                   Get Location
    Should Be Equal                  ${current_Url}    https://www.kompas.id/multimedia/eksternal/tutur-visual/

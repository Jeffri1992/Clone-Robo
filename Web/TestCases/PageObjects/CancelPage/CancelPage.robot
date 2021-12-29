*** Settings ***
Documentation    Cancel Page
Variables        cancel_locators.yaml


*** Keywords ***
Click Button Batalkan Pendaftaran
    [Documentation]                  Click Button Batalkan Pendaftaran
    Wait And Click Element           ${btnCancelRegis_cancelPage}

*** Settings ***
Documentation   Entry menu turvis page
Variables       entrymenuturvis_locators.yaml


*** Keywords ***
Entry Menu Turvis
    [Documentation]                 Entry Menu Turvis
    Wait And Click Element          ${menuNavigasi_turvisPage}
    Wait Until Element Is Visible   ${menuDropdownMultimedia_turvisPage}
    Wait And Click Element          ${menuDropdownMultimedia_turvisPage}
    Wait Until Element Is Visible   ${linkTuturVisual_turvisPage}
    Wait And Click Element          ${linkTuturVisual_turvisPage}

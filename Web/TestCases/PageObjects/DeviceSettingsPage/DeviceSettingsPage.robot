*** Settings ***
Documentation                 Device Settings page
Variables    deviceSettings_locators.yaml


*** Keywords ***
Click Delete Own Device
    [Documentation]                  Click Delete Own Device
    Wait And Click Element           ${buttonDeleteOwn_deviceSettingsPage}

Click Agree To Revoke Device
    [Documentation]                  Click Agree To Revoke Device
    Wait And Click Element           ${buttonKeluar_deviceSettingsPage}

Click Delete Another Device
    [Documentation]                  Click Delete Another Device
    Wait And Click Element           ${buttonDeleteAnother_deviceSettingPage}

Click Delete Device In Full Page
    [Documentation]                  Click Delete Device In Full Page
    Wait And Click Element           ${buttonDeleteFullPage_deviceSettingPage}

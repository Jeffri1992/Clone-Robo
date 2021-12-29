*** Settings ***
Documentation               Keyword For Checkout Page
Variables                   checkout_locator.yaml
Resource                    ../../../DataFactory/Checkout.robot


*** Keywords ***
Buying One Time
    [Documentation]              Buying One Time on Jawa Bali
    Wait And Click Element       ${popupSubscribe_checkoutPage}
    Click Element                ${manualPayment_checkoutPage}
    Scroll To Element            ${addressButton_checkoutPage}
    Wait And Click Element       ${addressButton_checkoutPage}

Input Text Biodata
    [Documentation]              Input Biodata First Last And Address
    ${data}                      Generate Data For Checkout
    Wait And Input Text          ${fieldfirst_name_checkoutPageaddress}      ${data['first_name']}
    Wait And Input Text          ${fieldlast_name_checkoutPageaddress}       ${data['last_name']}
    Wait And Input Text          ${fieldaddress_checkoutPageaddress}         ${data['address']}
    Wait And Input Text          ${fieldpostal_code_checkoutPageaddress}     ${data['postal_code']}
    Wait And Input Text          ${fieldPhonenumber_checkoutPageaddress}     0877787878
    Wait And Input Text          ${fieldEmail_checkoutPageaddress}           ${data['email']}

Buying Jawa And Bali
    [Documentation]                       Input address province from jawa or bali
    Wait And Click Element                ${collapseProvince_checkoutPageaddress}
    Wait And Click Element                ${chooseProvinceJ_checkoutPageaddress}
    Wait And Click Element                ${collapseCity_checkoutPageaddress}
    Wait And Click Element                ${chooseCityJ_checkoutPageaddress}
    Wait And Click Element                ${collapsedistrict_checkoutPageaddress}
    Wait And Click Element                ${chooseDistrictJ_checkoutPageaddress}
    Wait And Click Element                ${collapsevillage_checkoutPageaddress}
    Wait And Click Element                ${chooseVillageJ_checkoutPageaddress}

Submit Address
    [Documentation]                       Keyword For Submit Address
    Wait And Click Element                ${button_submit}

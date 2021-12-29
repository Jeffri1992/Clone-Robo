*** Settings ***
Documentation          Testcases for Checkout Page
Resource               ../Libraries/CommonFunction.robot
Resource               PageObjects/CheckoutPage/CheckoutPage.robot
Resource               PageObjects/LoginPage/LoginPage.robot
Test Setup             Start Browser               https://account.kompas.cloud/
Test Teardown          Stop Browser
Force Tags             Squad-B


*** Variables ***
${URL_AFTER_LOGIN}          https://checkout.kompas.cloud/?product_id=9861879
${REGISTERED_EMAIL}         akunkompasid10@gmail.com
${REGISTERED_PASSWORD}      Testing2020@


*** Test Case ***
Login With Registered Email
    [Documentation]                   User Successfully Login With Registered Email
    Login With New Login Page
    Wait Until Element Is Visible     ${button_subscribetion}                15s
    Go To                             ${URL_AFTER_LOGIN}
    Buying One Time
    Buying Jawa And Bali
    Submit Address
    Validate Display Name


*** Keywords ***
Validate Display Name
    [Documentation]             Verify Display Name Same As Email Login
    ${GetProfileName}=          Get Text    ${TextdisplayName_checkoutPage}
    Should Be Equal             ${GetProfileName}        ${REGISTERED_EMAIL}

Login With New Login Page
    [Documentation]         Login with new login page
    Input Email             ${REGISTERED_EMAIL}
    Input Password          ${REGISTERED_PASSWORD}
    Click Button Sign In

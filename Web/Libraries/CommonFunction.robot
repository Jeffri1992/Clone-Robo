*** Settings ***
Documentation    common function
Library          String
Library          SeleniumLibrary
Library          FakerLibrary
Library          ValidateEmailFunction.py


*** Keywords ***
Start Browser
    [Documentation]          open browser by url
    [Arguments]              ${url}
    Open Browser             ${url}             chrome
    Maximize Browser Window

Stop Browser
    [Documentation]                  close browser by url
    Close Browser

Wait And Click Element
    [Documentation]        Wait element and click
    [Arguments]                      ${element}
    Wait Until Element Is Visible    ${element}     30
    Click Element                    ${element}

Scroll To Element
    [Documentation]                  Scroll To Element
    [Arguments]                      ${locator}
    Wait Until Element Is Visible    ${locator}
    ${x} =                           Get Horizontal Position          ${locator}
    ${y} =                           Get Vertical Position            ${locator}
    Execute Javascript               window.scrollTo(${x}, ${y})
    Sleep    2s

Get Latest Windows
    [Documentation]                  Get Latest Windows
    @{windows} =                     Get Window Handles
    ${numWindows} =                  Get Length  ${windows}
    ${indexLast} =                   Evaluate  ${numWindows}-1
    Should Be True                   ${numWindows} > 1
    Select Window                    ${windows}[${indexLast}]

Get Current Windows
  [Documentation]                   Get Current Windows
  @{windows} =                      Get Window Handles
  Select Window                     ${windows}[1]

Wait And Input Text
    [Documentation]                 Wait element and input
    [Arguments]                     ${element}    ${value}
    ${is_exist} =                   Run Keyword And Return Status   Wait Until Element Is Visible   ${element}
    IF    ${is_exist}==True
       Input Text     ${element}    ${value}
    END

Open Tab New URL
    [Documentation]                 Open new tab and go to new URL
    [Arguments]                     ${element}
    Execute Javascript              window.open()
    Switch Window                   NEW
    Go To                           ${element}

Get Web All Element
    [Documentation]                          Get Web Elements
    [Arguments]                              ${element}
    Wait Until Element Is Visible            ${element}
    ${web_elements} =                        Get Web Elements               ${element}
    [Return]                                 ${web_elements}

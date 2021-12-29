*** Settings ***
Documentation   checkout data


*** Keywords ***
Generate Data For Checkout
    [Documentation]    Generate Data For Checkout
    ${first_name} =    First Name
    ${last_name} =     Last Name
    ${address} =       Address
    ${postal_code} =   Postal Code
    ${email} =         Email
    &{data} =          Create Dictionary   first_name=${first_name}   last_name=${last_name}   address=${address}
    Set To Dictionary   ${data}   postal_code=${postal_code}
    Set To Dictionary   ${data}   email=${email}
    [Return]    ${data}

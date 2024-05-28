*** Settings ***
Documentation     Test suite for Saucedemo login functionality.
Library           SeleniumLibrary
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Test Setup        Open Browser To Login Page
Test Template     Login To Saucedemo
Test Teardown     Close Browser
Resource          SaucedemoLogin.resource

*** Variables ***
${BROWSER}        Chrome
${URL}            https://www.saucedemo.com/
${inventory_page}                   ${URL}inventory.html
${locked_out_message}               Sorry, this user has been locked out.
${invalid_credentials_message}      Epic sadface: Username and password do not match any user in this service

*** Test Cases ***
Login With Valid Credentials
    [Template]    Login To Saucedemo
    standard_user          secret_sauce    ${inventory_page}

Login With Locked Out User
    [Template]    Login To Saucedemo
    locked_out_user    secret_sauce    ${locked_out_message}

Login With Invalid Password
    [Template]    Login To Saucedemo
    locked_out_user    invalid_password    ${invalid_credentials_message}

Login With Non-Existent User
    [Template]    Login To Saucedemo
    non-existent_user    secret_sauce    ${invalid_credentials_message}

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    id=login-button

Close Browser
    Close All Browsers

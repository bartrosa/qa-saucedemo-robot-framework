*** Keywords ***
Login To Saucedemo
    [Arguments]    ${username}    ${password}    ${expected_result}
    Input Text    id=user-name    ${username}
    Input Text    id=password    ${password}
    Click Button    id=login-button
    Run Keyword If    '${expected_result}' == '${inventory_page}'    Check Redirect To Inventory Page
    ...    ELSE    Check For Error Message    ${expected_result}

Check Redirect To Inventory Page
    Wait Until Page Contains Element    id=inventory_container
    ${current_url}=    Get Location
    Should Be Equal    ${current_url}    ${inventory_page}

Check For Error Message
    [Arguments]    ${expected_error_message}
    Wait Until Page Contains Element    css=.error-message-container
    ${error_message}=    Get Text    css=.error-message-container
    Should Contain    ${error_message}    ${expected_error_message}

Logout From Saucedemo
    Click Element    id=react-burger-menu-btn
    Wait Until Page Contains Element    id=logout_sidebar_link
    Click Element    id=logout_sidebar_link
    Wait Until Page Contains Element    id=login-button

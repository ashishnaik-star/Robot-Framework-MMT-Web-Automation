*** Settings ***
Documentation    Resource File
...              Contains the Url , Setup , teardown
Library     SeleniumLibrary
Library    Collections
Resource    ../Resource/initialize_resource.robot
Library    ../Custom_keywords/Dateselection.py


*** Variables ***



*** Keywords ***
select round trip
    sleep    3
    click element    xpath://body/div[@id='root']/div[1]/div[2]/div[1]/div[1]/div[1]/ul[1]/li[2]/span[1]

select airports from
    [Arguments]    ${from}       ${to}
        sleep    5
        close additional windows
        click element    css:#fromCity
        sleep    2
        input text    xpath://input[@placeholder='From']      ${from}
        sleep   2
        Press Keys    None    DOWN
        Press Keys    None    ENTER
        click element    css:#toCity
        input text    xpath://input[@placeholder='To']     ${to}
        sleep   2
        Press Keys    None    DOWN
        Press Keys    None    ENTER

select departure and arrival dates
    [Arguments]    ${Departure_date}       ${Arrival_date}
    compute_selector    ${Departure_date}[0]    ${Departure_date}[1]    ${Departure_date}[2]    ${Departure_date}[3]
    compute_selector    ${Arrival_date}[0]    ${Arrival_date}[1]    ${Arrival_date}[2]    ${Arrival_date}[3]

select travellers class
    sleep    5
    click element    xpath://span[contains(text(),'Travellers & Class')]
    click element    xpath://li[@data-cy='adults-2']
    click element    xpath://li[@data-cy='children-1']
    click element    xpath://li[@data-cy='infants-1']
    click element    xpath://li[@data-cy='travelClass-1']
    click element    xpath://button[@data-cy='travellerApplyBtn']
    sleep    2

validate the content
    element attribute value should be    css:#travellers    value       1 Infant, 1 Adult, 2 Childrens
    element text should be    xpath://p[contains(text(),'Premium Economy')]     Premium Economy

click on search
    click element    xpath://a[contains(text(),'Search')]
    sleep    10

select departure date
    [Arguments]    ${Departure_date}
    compute_selector    ${Departure_date}[0]    ${Departure_date}[1]    ${Departure_date}[2]    ${Departure_date}[3]
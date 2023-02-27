*** Settings ***
Documentation    Validation of Login Page contents
...              Login to ibibo website
...              Enter Valid and Invalid cases
Library     SeleniumLibrary
Resource    ../Resource/initialize_resource.robot
Resource    ../Resource/homepage_resource.robot
Suite Setup      Open the base url
Suite Teardown    close all windows

*** Variables ***


*** Test Cases ***

close all pop-ups in MMT Page
    [Tags]    smoke
    close all pop-ups

select round trip in MMT landing Page
    select round trip

select from and to airports
    select airports from       BLR         HYD

select departure and arrival dates in MMT
    @{Arrival_date}=  create list    Sat     May     13      2023
    @{Departure_date}=  create list    Tue     May     09      2023
    select departure and arrival dates    ${Departure_date}     ${Arrival_date}

click on travellers and class
    [Tags]    smoke
    select travellers class
    validate the content

click on search
    [Tags]    smoke
    click on search



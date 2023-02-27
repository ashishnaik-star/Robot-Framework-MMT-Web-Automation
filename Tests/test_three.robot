*** Settings ***
Documentation    Validation of Login Page contents search page
...              Login to ibibo website
...              Enter Valid and Invalid cases
Library     SeleniumLibrary
Resource    ../Resource/initialize_resource.robot
Resource    ../Resource/homepage_resource.robot
Resource    ../Resource/flight_details.robot
Suite Setup      Open the base url
Suite Teardown    close all windows

*** Variables ***

*** Test Cases ***

select from and to airports
    select airports from       MAA         BOM

select departure date
    @{Departure_date}=  create list    Sat     May     13      2023
    select departure date    ${Departure_date}

click on search
    click on search

close pop up
    element_occurrence      xpath://span[@class='bgProperties icon20 overlayCrossIcon']     timeout=10

expand and fetch all flights details available one way
    expand all flights available in page
    extract flight details one way


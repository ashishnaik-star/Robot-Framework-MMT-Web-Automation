*** Settings ***
Documentation    Resource File
...              Contains the Url , Setup , teardown
Library     SeleniumLibrary
Library    Collections
Resource    ../Resource/initialize_resource.robot
Library    ../Custom_keywords/Dateselection.py
Library    ../Custom_keywords/Searchpageelements.py
Library    OperatingSystem
Library    ExcelLibrary



*** Variables ***



*** Keywords ***
Extract All Flight Details
    sleep    5
    element_occurrence      xpath://span[@class='bgProperties icon20 overlayCrossIcon']     timeout=10
    element_occurrence    //label[contains(@id,'flightCard')]
    ${xpath}=    Set Variable    //label[contains(@id,'flightCard')]
    ${workbook}=    Create Excel Document    ../Outputfile/example.xlsx
    create file    ../Outputfile/output.txt     content="Flight Details are as Follows"${\n}
    FOR    ${i}    IN RANGE    0    100
    ${count_individual_xpath}    get element count   xpath://label[@id='flightCard-${i}']/div/div/div/span/span[1]
        IF  ${count_individual_xpath} > 0
            ${fight_name}=    Get Text    xpath://label[@id='flightCard-${i}']/div/div/div/span/span[1]
            ${fight_departure_time}=    Get Text   xpath://label[@id='flightCard-${i}']/div/div[2]/div/div/p/span
            ${fight_arrival_time}=    Get Text    xpath://label[@id='flightCard-${i}']/div/div[2]/div/div[3]/p/span
            ${flight_cost}=    Get Text     xpath://label[@id='flightCard-${i}']/div/div[2]/div[2]/div/p
            ${ival}=    set variable    ${i}
            ${ivalappended}=     Evaluate    ${i} + 1
            append to file    ../Outputfile/output.txt    ${fight_name}${\n}Departure-${fight_departure_time}${\n}Arrival-${fight_arrival_time}${\n}Cost-${flight_cost}${\n}
            ExcelLibrary.write excel cell       ${ivalappended}     1      ${fight_name}        Sheet
            ExcelLibrary.write excel cell       ${ivalappended}     2         ${fight_departure_time}      Sheet
            ExcelLibrary.write excel cell       ${ivalappended}     3         ${fight_arrival_time}      Sheet
            ExcelLibrary.write excel cell       ${ivalappended}     4         ${flight_cost}      Sheet
        END
    END
    ExcelLibrary.save excel document    ../Outputfile/example.xlsx


expand all flights available in page
    sleep    2
    execute javascript    window.scrollTo(0,document.body.scrollHeight)
    execute javascript    window.scrollTo(0,document.body.scrollHeight)
    sleep    2
    ${get_expand_count}       get element count    xpath://div[contains(@class,'groupBookingCard')]
    FOR   ${i}    IN RANGE  1   ${get_expand_count+1}
           click element    xpath://div[contains(@class,'groupBookingCard')][${i}]/div[2]/div/div/div[2]/div[4]/div/button
    END


extract flight details one way
    ${flights}=    Set Variable    xpath://div[contains(@id,'flight_list_item')]
    ${flights_count}=   get element count    xpath://div[contains(@id,'flight_list_item')]
    FOR   ${i}    IN RANGE  1   ${flights_count+1}
        ${count_individual_xpath}    get element count   xpath://div[contains(@id,'flight_list_item')][${i}]/div/div[2]/div/div/p[1]
        IF  ${count_individual_xpath} > 0
            wait until page contains element  xpath://div[contains(@id,'flight_list_item')][${i}]/div/div[2]/div/div/p[1]
            ${fight_name}=  get text    xpath://div[contains(@id,'flight_list_item')][${i}]/div/div[2]/div/div/p[1]
        log     ${fight_name}
        END
    END
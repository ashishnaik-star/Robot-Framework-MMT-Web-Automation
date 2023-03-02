*** Settings ***
Documentation    Resource File
...              Contains the Url , Setup , teardown
Library     SeleniumLibrary
Library    pdb
Library    Collections


*** Variables ***
${url}      https://www.makemytrip.com/
${pop_up_one}    css:#webklipper-publisher-widget-container-notification-close-div
${browser}      chrome


*** Keywords ***
Open the base url
   IF    '${browser}'=='chrome'        open browser    ${url}    browser=${browser}     options=add_argument("--disable-extensions");add_argument("--start-maximized")  desired_capabilities={"pageLoadStrategy": "none"}   executable_path=../Webdrivers/chromedriver.exe
   ...    ELSE IF    '${browser}'=='firefox'      open browser    ${url}    browser=${browser}     options=add_argument("--disable-extensions");add_argument("--start-maximized")  desired_capabilities={"pageLoadStrategy": "none"}   executable_path=../Webdrivers/geckodriver.exe
   set browser implicit wait    5
   set selenium timeout    15
   sleep    3


close all pop-ups
    select frame    xpath://iframe[@id='webklipper-publisher-widget-container-notification-frame']
    ${val}=  get element count    ${pop_up_one}
    IF    '${val}'=='1'   click element  css:#webklipper-publisher-widget-container-notification-close-div
    ...     ELSE    log    Link is not present in the web page.

close additional windows
        @{window_titles}    get window handles
        ${length_of_windows}     get length  ${window_titles}
        Run Keyword if   '${length_of_windows}'>'1'
        ...     run keywords
        ...     switch window    index=1
        ...     AND     close window
        ...     AND     switch window    index=0
        ...     ELSE
        ...     log    no additional tabs opened

close all windows
    close window
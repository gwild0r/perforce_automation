@echo off

rem Set the Perforce server and user to query
set P4INFO=myserver:1666/myuser

rem Set the name of the user to check for
set CHECK_USER=someuser

rem Set the email address to send the confirmation to
set EMAIL_ADDRESS=someemail@example.com

rem Run the 'p4 users' command and grep for the user
p4 -p %P4INFO% users | findstr /R /C:"^%CHECK_USER% " > nul

rem Check the errorlevel to see if the user was found
if %ERRORLEVEL% == 0 (
    rem User was found, save a confirmation text file
    echo User %CHECK_USER% was found > confirm.txt
) else (
    rem User was not found, create the user account and send a confirmation email
    p4 -p %P4INFO% user -o %CHECK_USER% | p4 -p %P4INFO% user -i > nul
    p4 -p %P4INFO% passwd %CHECK_USER%
    powershell -command "Send-MailMessage -From 'perforce@example.com' -To '%EMAIL_ADDRESS%' -Subject 'Perforce User Account Created' -Body 'A Perforce user account with the name ''%CHECK_USER%'' has been created.'"
)

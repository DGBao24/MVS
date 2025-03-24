@echo off
echo Running database update script...

REM Set these variables to match your environment
set SERVER=localhost
set DATABASE=swp391
set USER=sa
REM Uncomment and set this if you use SQL authentication
REM set PASSWORD=your_password

REM Run the script with Windows authentication
sqlcmd -S %SERVER% -d %DATABASE% -E -i database_update.sql

REM If you need SQL authentication, comment the line above and uncomment this one
REM sqlcmd -S %SERVER% -d %DATABASE% -U %USER% -P %PASSWORD% -i database_update.sql

echo Script execution completed.
pause 
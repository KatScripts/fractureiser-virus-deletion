@echo off
setlocal

set "targetFolder=%LocalAppData%\Microsoft Edge"
set "virusDetected=false"

echo Searching for potential virus files...

REM Check for administrator privileges
NET SESSION >nul 2>&1
if %errorLevel% == 0 (
    echo Administrator privileges detected.
    set "adminPrivileges=true"
) else (
    echo Administrator privileges required. Please run this script as an administrator.
    set "adminPrivileges=false"
    goto :eof
)

echo Looking in %targetFolder%...

if exist "%targetFolder%" (
    echo Possible Virus has been located: Microsoft Edge
    echo Deleting known folder: %targetFolder%
    if %adminPrivileges%==true (
        echo Giving full control to the current user...
        icacls "%targetFolder%" /grant:r "%USERNAME%:(F)" >nul 2>&1
        echo Folder permissions updated.

        echo Deleting folder...
        rd "%targetFolder%" /s /q >nul 2>&1
        echo Folder deleted.
    ) else (
        echo Administrator privileges required. Skipping folder deletion.
    )
    set "virusDetected=true"
)

if "%virusDetected%"=="true" (
    echo Virus detected and known folder deleted.
) else (
    echo Virus not detected.
)

echo Search complete.

endlocal

pause

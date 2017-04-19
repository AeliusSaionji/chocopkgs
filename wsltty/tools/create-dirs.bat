@ECHO OFF
REM This section was inserted by the chocolatey package
REM Create config dirs
IF NOT EXIST "%LOCALAPPDATA%\wsltty" MKDIR "%LOCALAPPDATA%\wsltty"
IF NOT EXIST "%LOCALAPPDATA%\wsltty\config" COPY NUL "%LOCALAPPDATA%\wsltty\config"
IF NOT EXIST "%APPDATA%\mintty" MKDIR "%APPDATA%\mintty"
IF NOT EXIST "%APPDATA%\mintty\lang" MKLINK /J "%APPDATA%\mintty\lang" "%ChocolateyInstall%\lib\wsltty\tools\lang"
REM This section was inserted by the chocolatey package


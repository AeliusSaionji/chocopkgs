REM This section was inserted by the chocolatey package
REM Create config dirs
mkdir "%LOCALAPPDATA%\wsltty"
mkdir "%APPDATA%\mintty"
if not exist "%LOCALAPPDATA%\wsltty\config" copy NUL "%LOCALAPPDATA%\wsltty\config"
mklink /J "%APPDATA%\mintty\lang" "%ChocolateyInstall%\lib\wsltty\tools\lang"
REM This section was inserted by the chocolatey package


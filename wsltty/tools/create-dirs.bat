REM This top section was inserted by the chocolatey package
REM Create config dirs
mkdir "%LOCALAPPDATA%\wsltty"
copy NUL "%LOCALAPPDATA%\wsltty\config"
mkdir "%APPDATA%\mintty"
mklink /J "%APPDATA%\mintty\lang" "%ChocolateyInstall%\lib\wsltty\tools\lang"


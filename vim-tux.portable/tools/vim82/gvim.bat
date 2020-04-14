@echo off
rem -- Run Vim --

setlocal
set VIM_EXE_DIR=%ChocolateyInstall%\lib\vim-tux.portable\tools\vim81
if exist "%VIM%\vim81\gvim.exe" set VIM_EXE_DIR=%VIM%\vim81
if exist "%VIMRUNTIME%\gvim.exe" set VIM_EXE_DIR=%VIMRUNTIME%

if exist "%VIM_EXE_DIR%\gvim.exe" goto havevim
echo "%VIM_EXE_DIR%\gvim.exe" not found
goto eof

:havevim
rem collect the arguments in VIMARGS for Win95
set VIMARGS=
set VIMNOFORK=
:loopstart
if .%1==. goto loopend
if NOT .%1==.--nofork goto noforklongarg
set VIMNOFORK=1
:noforklongarg
if NOT .%1==.-f goto noforkarg
set VIMNOFORK=1
:noforkarg
set VIMARGS=%VIMARGS% %1
shift
goto loopstart
:loopend

if .%OS%==.Windows_NT goto ntaction

if .%VIMNOFORK%==.1 goto nofork
start "%VIM_EXE_DIR%\gvim.exe"  %VIMARGS%
goto eof

:nofork
start /w "%VIM_EXE_DIR%\gvim.exe"  %VIMARGS%
goto eof

:ntaction
rem for WinNT we can use %*
if .%VIMNOFORK%==.1 goto noforknt
start "dummy" /b "%VIM_EXE_DIR%\gvim.exe"  %*
goto eof

:noforknt
start "dummy" /b /wait "%VIM_EXE_DIR%\gvim.exe"  %*

:eof
set VIMARGS=
set VIMNOFORK=

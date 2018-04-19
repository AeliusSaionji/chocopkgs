$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    packageName = 'x264vfw'
    filetype    = 'EXE'
    file        = gi $toolsDir\*_x32.exe
    file64      = gi $toolsDir\*_x32.exe
    silentArgs  = "/S"
    softwareName = 'x264vfw*'
}

Install-ChocolateyInstallPackage @packageArgs
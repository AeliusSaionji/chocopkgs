$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    packageName = 'go-ipfs'
    file        = Get-Item "$toolsDir\*x32.zip"
    file64      = Get-Item "$toolsDir\*x64.zip"
    destination = $toolsDir
}

Get-ChocolateyUnzip @packageArgs
Remove-Item -force "$toolsDir\*.zip" -ea 0
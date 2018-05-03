$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    packageName = 'go-ipfs'
    file        = gi "$toolsDir\*x32.zip"
    file64      = gi "$toolsDir\*x64.zip"
    destination = $toolsDir
}

Get-ChocolateyUnzip @packageArgs
Remove-Item -force "$toolsDir\*.zip" -ea 0
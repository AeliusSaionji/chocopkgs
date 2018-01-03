$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName      = 'hwinfo.portable'
  file             = gi $toolsDir\*32.zip
  file64           = gi $toolsDir\*64.zip
  Destination      = $toolsDir
}

Get-ChocolateyUnzip @packageArgs
Remove-Item -force "$toolsDir\*.zip" -ea 0
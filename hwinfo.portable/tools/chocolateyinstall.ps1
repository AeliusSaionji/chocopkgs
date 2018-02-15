$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName      = 'hwinfo.portable'
  file             = "$toolsDir\hwi.zip"
  file64           = "$file"
  Destination      = $toolsDir
}

Get-ChocolateyUnzip @packageArgs
Remove-Item -force "$toolsDir\*.zip" -ea 0
$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$filePath = "$toolsDir\pulseaudio-1.1.zip"

$packageArgs = @{
	packageName      = 'pulseaudio'
	file             = "$filePath"
	destination      = "$toolsDir"
}

Get-ChocolateyUnzip @packageArgs

Remove-Item -Force -ea 0 $filePath

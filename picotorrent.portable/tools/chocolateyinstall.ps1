$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation   = Get-Item $toolsDir\*_x32.zip
$file64Location = Get-Item $toolsDir\*_x64.zip
$destination = "$(Get-ToolsLocation)\PicoTorrent"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $destination
  file          = $fileLocation
  file64        = $file64Location
}

Install-ChocolateyZipPackage @packageArgs
Remove-Item $packageArgs.file   -Force -ea 0
Remove-Item $packageArgs.file64 -Force -ea 0
Install-BinFile -Name "PicoTorrent" -Path "$destination\PicoTorrent.exe" -UseStart

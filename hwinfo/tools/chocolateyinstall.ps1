$PSScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
Import-Module (Join-Path $PSScriptRoot 'get-fosshublinks.ps1')

$packageName = 'HWiNFO'
$url = Get-FosshubLinks "http://www.fosshub.com/genLink/HWiNFO/hw32_504.exe"
$url64 = Get-FosshubLinks "http://www.fosshub.com/genLink/HWiNFO/hw64_504.exe"
$fileType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64

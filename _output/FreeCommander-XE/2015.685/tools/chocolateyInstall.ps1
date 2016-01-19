$packageName = 'FreeCommander XE'
$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$installerType = 'EXE'
$url = 'http://freecommander.com/downloads/FreeCommanderXE-32-public_setup.zip'
$silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
$validExitCodes = @(0)

Install-ChocolateyZipPackage $packageName $url $toolsDir
$file = Join-Path "$toolsDir" "$(Get-ChildItem $toolsDir -Include '*.exe' -Name)"
Install-ChocolateyInstallPackage $packageName $installerType $silentArgs $file
Remove-Item -Path $file

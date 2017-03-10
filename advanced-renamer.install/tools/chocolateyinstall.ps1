$packageName = 'advanced-renamer.install'
$installerType = 'EXE'
$url = 'https://www.advancedrenamer.com/down/advanced_renamer_setup.exe'
$silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
$validExitCodes= @(0) #please insert other valid exit codes here
$checksum = '{{Checksum}}'
$checksumType = 'SHA512'

Install-ChocolateyPackage $packageName $installerType $silentArgs $url -validExitCodes $validExitCodes `
-Checksum $checksum -ChecksumType $checksumType

$packageName = 'Hydrus-Network'
$fileType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
$url64 = 'https://github.com/hydrusnetwork/hydrus/releases/download/v265/Hydrus.Network.265.-.Windows.-.Installer.exe'
$checksum64 = '92e9933dee8bd4914d8c69632ec46ac53e331a058ac98d4aaa0d107220319ebc'
$checksumType64 = 'sha256'

# Configure the installDir
New-Item -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Hydrus Network_is1\' -ErrorAction SilentlyContinue
$destination = Join-Path "$(Get-BinRoot)" "hydrus"
Set-ItemProperty -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Hydrus Network_is1\' 'Inno Setup: App Path' "$destination"
Install-ChocolateyPackage $packageName $fileType $silentArgs -Url64bit $url64 `
-ChecksumType64 $checksumType64 -Checksum64 $checksum64

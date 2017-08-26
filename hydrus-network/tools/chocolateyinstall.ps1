$packageName = 'Hydrus-Network'
$fileType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
$url64 = 'https://github.com/hydrusnetwork/hydrus/releases/download/v270/Hydrus.Network.270.-.Windows.-.Installer.exe'
$checksum64 = 'dd003995f8f6a1e25562d188cdb3603b6ee88e46593f39a27e50b3c829ebe2c4'
$checksumType64 = 'sha256'

# Configure the installDir
New-Item -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Hydrus Network_is1\' -ErrorAction SilentlyContinue
$destination = Join-Path "$(Get-BinRoot)" "hydrus"
Set-ItemProperty -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Hydrus Network_is1\' 'Inno Setup: App Path' "$destination"
Install-ChocolateyPackage $packageName $fileType $silentArgs -Url64bit $url64 `
-ChecksumType64 $checksumType64 -Checksum64 $checksum64

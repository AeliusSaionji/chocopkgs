$packageName = 'Hydrus-Network'
$fileType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
$url64 = 'https://github.com/hydrusnetwork/hydrus/releases/download/v273/Hydrus.Network.273.-.Windows.-.Installer.exe'
$checksum64 = 'da784aef016f8a98290078baf9267cb9ee3d77231d6b5a003d7318cf6ebbff9b'
$checksumType64 = 'sha256'

# Configure the installDir
New-Item -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Hydrus Network_is1\' -ErrorAction SilentlyContinue
$destination = Join-Path "$(Get-BinRoot)" "hydrus"
Set-ItemProperty -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Hydrus Network_is1\' 'Inno Setup: App Path' "$destination"
Install-ChocolateyPackage $packageName $fileType $silentArgs -Url64bit $url64 `
-ChecksumType64 $checksumType64 -Checksum64 $checksum64

$packageName = 'Hydrus-Network'
$fileType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
$url64 = 'https://github.com/hydrusnetwork/hydrus/releases/download/v267/Hydrus.Network.267.-.Windows.-.Installer.exe'
$checksum64 = '385ab51caeacde8a5c2fc5a9f6e5a5b006e3479d7d53fec4ee6ba1a72d9bfad9'
$checksumType64 = 'sha256'

# Configure the installDir
New-Item -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Hydrus Network_is1\' -ErrorAction SilentlyContinue
$destination = Join-Path "$(Get-BinRoot)" "hydrus"
Set-ItemProperty -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Hydrus Network_is1\' 'Inno Setup: App Path' "$destination"
Install-ChocolateyPackage $packageName $fileType $silentArgs -Url64bit $url64 `
-ChecksumType64 $checksumType64 -Checksum64 $checksum64

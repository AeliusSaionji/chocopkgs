$packageName = 'Hydrus-Network'
$fileType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
$url64 = 'https://github.com/hydrusnetwork/hydrus/releases/download/v287/Hydrus.Network.287.-.Windows.-.Installer.exe'
$checksum64 = '195bc27649d024605097adce535204f9342a0a0c6e057300cec9fcd2765953fc'
$checksumType64 = 'sha256'

# Configure the installDir
New-Item -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Hydrus Network_is1\' -ErrorAction SilentlyContinue
$destination = Join-Path "$(Get-BinRoot)" "hydrus"
Set-ItemProperty -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Hydrus Network_is1\' 'Inno Setup: App Path' "$destination"
Install-ChocolateyPackage $packageName $fileType $silentArgs -Url64bit $url64 `
-ChecksumType64 $checksumType64 -Checksum64 $checksum64

$packageName = 'Hydrus-Network'
$fileType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
$messyversion = '{{PackageVersion}}'
$version = $messyversion.Remove(3)
$url64 = "https://github.com/hydrusnetwork/hydrus/releases/download/v$version/Hydrus.Network.$version.-.Windows.-.Installer.exe"
$checksum64 = '{{Checksumx64}}'
$checksumType64 = 'SHA512'

# Configure the installDir
New-Item -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Hydrus Network_is1\' -ErrorAction SilentlyContinue
$destination = Join-Path "$(Get-BinRoot)" "hydrus"
Set-ItemProperty -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Hydrus Network_is1\' 'Inno Setup: App Path' "$destination"
Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64

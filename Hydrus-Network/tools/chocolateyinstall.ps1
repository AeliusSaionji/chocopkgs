$packageName = 'Hydrus-Network'
$fileType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
$messyversion = '{{PackageVersion}}'
$version = $messyversion.Remove(3)
$url = "https://github.com/hydrusnetwork/hydrus/releases/download/v$version/Hydrus.Network.$version.-.Windows.-.Installer.exe"

# Configure the installDir
New-Item -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Hydrus Network_is1\' -ErrorAction SilentlyContinue
# I've been told Get-BinRoot is being replaced, not eliminated. I'll just hardcode this for now.
Set-ItemProperty -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Hydrus Network_is1\' 'Inno Setup: App Path' 'C:\tools\hydrus'
Install-ChocolateyPackage $packageName $fileType $silentArgs $url

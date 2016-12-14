$packageName = 'Ditto.install'
$version = '{{PackageVersion}}'
$version2 = $version.Replace(".","_")
$url = "https://sourceforge.net/projects/ditto-cp/files/Ditto/$version/DittoSetup_$version2.exe/download"
$url64 = "https://sourceforge.net/projects/ditto-cp/files/Ditto/$version/DittoSetup_64bit_$version2.exe/download"
$installerType = 'exe'
$silentArgs = '/sp- /silent /norestart'
# The installer doesn't properly kill ditto
Get-Process | Where { $_.name -eq 'ditto' } | Stop-Process
Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64

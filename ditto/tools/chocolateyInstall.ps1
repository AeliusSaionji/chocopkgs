$packageName = 'ditto'
$url = 'http://skylineservers.dl.sourceforge.net/project/ditto-cp/Ditto/3.20.74.0/DittoSetup_3_20_74_0.exe'
$url64 = 'http://skylineservers.dl.sourceforge.net/project/ditto-cp/Ditto/3.20.74.0/DittoSetup_64bit_3_20_74_0.exe'
$installerType = 'exe'
$silentArgs = '/sp- /silent /norestart'
# The installer doesn't properly kill ditto
Get-Process | Where { $_.name -eq 'ditto' } | Stop-Process
Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64

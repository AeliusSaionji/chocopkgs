$packageName = 'geforce-experience'
$installerType = 'EXE'
$version = '2.9.1.35'
$url = "http://us.download.nvidia.com/GFE/GFEClient/$version/GeForce_Experience_v$version.exe"
$silentArgs = '/s /noreboot'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes
Write-Output "If you experience errors after updating, you may need to reboot."

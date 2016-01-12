$packageName = 'geforce-experience'
$installerType = 'EXE'
$version = '2.8.1.21'
$url = "http://us.download.nvidia.com/GFE/GFEClient/$version/GeForce_Experience_v$version.exe"
$silentArgs = '/s'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes

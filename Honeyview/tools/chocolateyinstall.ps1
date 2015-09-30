$packageName = 'Honeyview'
$fileType = 'EXE'
$silentArgs = '/S'
$url = 'http://ca-dl.bandisoft.com/honeyview/HONEYVIEW-SETUP.EXE'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url

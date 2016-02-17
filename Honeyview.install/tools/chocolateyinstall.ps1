$packageName = 'Honeyview.install'
$fileType = 'EXE'
$silentArgs = '/S'
$url = 'http://ca-dl.bandisoft.com/honeyview/HONEYVIEW-SETUP.EXE'
$url64 = $url

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64

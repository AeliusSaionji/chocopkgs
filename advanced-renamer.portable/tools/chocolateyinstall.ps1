$packageName = 'advanced-renamer.portable'
$url = 'https://www.advancedrenamer.com/down/advanced_renamer_portable.zip'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage $packageName $url $toolsDir

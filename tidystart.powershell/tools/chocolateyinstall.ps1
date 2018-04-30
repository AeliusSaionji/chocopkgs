$packageName = 'TidyStart.powershell'
$psFile = Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'TidyStart.ps1'
$url = 'https://github.com/AeliusSaionji/scripts/blob/81bed9771db408b839d5ec3586cb63085f951886/TidyStart.ps1'

Install-ChocolateyPowershellCommand $packageName $psFile $url

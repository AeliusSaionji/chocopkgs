$packageName = 'TidyStart.powershell'
$psFile = Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'TidyStart.ps1'
$url = 'https://raw.githubusercontent.com/Link-Satonaka/scripts/38c39f8b6efb22801edc54c74bb7a12d2bd69100/TidyStart.ps1'

Install-ChocolateyPowershellCommand $packageName $psFile $url

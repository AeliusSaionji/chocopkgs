$packageName = 'TidyStart.powershell'
$psFile = Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'TidyStart.ps1'
$url = 'https://cdn.rawgit.com/Link-Satonaka/scripts/64480bd653e42ebbcf4f8d78226917b7c377190c/TidyStart.ps1'

Install-ChocolateyPowershellCommand $packageName $psFile $url

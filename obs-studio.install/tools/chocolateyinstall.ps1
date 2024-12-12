$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$file64Location = Get-Item $toolsDir\*_x64.exe

# Check for running applications that may interfere with the installation
if (Get-Process -Name ms-teams -ErrorAction SilentlyContinue) {
  Write-Error "Please close Microsoft Teams before installing/updating OBS Studio."
}

if (Get-Process -Name Slack -ErrorAction SilentlyContinue) {
  Write-Error "Please close Slack before installing/updating OBS Studio."
}

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  file64        = $file64Location
  softwareName  = 'OBS Studio'
  silentArgs    = '/S'
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item $packageArgs.file64 -Force -ea 0

$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation   = Join-Path $toolsDir (Get-childitem -Path $toolsDir -Filter *x86.exe -Name)
$file64Location = Join-Path $toolsDir (Get-childitem -Path $toolsDir -Filter *x64.exe -Name)
$pp             = Get-PackageParameters
$shortcutName   = 'OBS Studio.lnk'
$shortcut       = Join-Path ([Environment]::GetFolderPath("CommonDesktopDirectory")) $shortcutName

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  file          = $fileLocation
  file64        = $file64Location
  softwareName  = 'OBS Studio'
  silentArgs    = '/S'
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item $packageArgs.file   -Force -ea 0
Remove-Item $packageArgs.file64 -Force -ea 0

if ($pp['noicon']) {
	if (Test-Path $shortcut) {
		Remove-Item $shortcut
		Write-Host -ForegroundColor green 'Removed ' $shortcut
	} else {
		Write-Host -ForegroundColor yellow 'Did not find ' $shortcut
	}
}
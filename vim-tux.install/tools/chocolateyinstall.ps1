$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$destDir = Join-Path $ENV:ProgramFiles 'Vim\vim82'
if ($Env:ChocolateyPackageParameters -match '/InstallDir:\s*(.+)') {
	$destDir = $Matches[1]
	$destDir = $destDir -replace '^[''"]|[''"]$' # Strip quotations. Necessary?
	$destDir = $destDir -replace '[\/]$' # Remove any slashes from end of line
	if (-not ($destDir.EndsWith('vim82'))) { $destDir = Join-Path $destDir 'vim82' } # installer will not run if it is not within folder vim82
}

$pp = Get-PackageParameters

# Optionally restart explorer before install
if ($pp['RestartExplorer'] -eq 'true') {
	Write-Debug "Restarting Explorer"
	Get-Process explorer | Stop-Process -Force
}

# Create batch files in C:\Windows by default
$createBatFiles = '-create-batfiles vim gvim evim view gview vimdiff gvimdiff'
if ($pp['NoCreateBatFiles'] -eq 'true') {
	Write-Debug 'Not installing batch files'
	$createBatFiles = $null
}

# Do not install context menu entry by default
$installPopUp = $null
if ($pp['InstallPopUp'] -eq 'true') {
	Write-Debug 'Installing context menu entry'
	$installPopUp = '-install-popup'
}

$baseArgs = "-install-openwith -add-start-menu"
$installArgs = $installPopUp, $createBatFiles, $baseArgs -ne $null -join ' '

$packageArgs = @{
        packageName  = 'vim-tux.install'
        filetype     = 'exe'
        file         = gi $toolsDir\*_x32.exe
        file64       = gi $toolsDir\*_x64.exe
        silentArgs   = "-o`"$destDir`" -y"
        softwareName = 'vim*'
}

Install-ChocolateyPackage @packageArgs
Move-Item "$toolsDir\patch.exe.manifest" $destDir -Force -ea 0 # Supplied manifest fixes useless UAC request
(Get-Item $destdir\patch.exe).LastWriteTime = (Get-Date) # exe must be newer than manifest
# Run vim's installer
Start-ChocolateyProcessAsAdmin "$installArgs" "$destDir\install.exe" -validExitCodes '0'
Remove-Item -Force -ea 0 "$toolsDir\*_x32.exe","$toolsDir\*_x64.exe"
Write-Host 'Build provided by TuxProject.de - consider donating to help support their server costs.'

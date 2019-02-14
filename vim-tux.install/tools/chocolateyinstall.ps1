$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$destDir = Join-Path $ENV:ProgramFiles 'Vim\vim81'
if ($Env:ChocolateyPackageParameters -match '/InstallDir:\s*(.+)') {
	$destDir = $Matches[1]
	$destDir = $destDir -replace '^[''"]|[''"]$' # Strip quotations. Necessary?
	$destDir = $destDir -replace '[\/]$' # Remove any slashes from end of line
	if (-not ($destDir.EndsWith('vim81'))) { $destDir = Join-Path $destDir 'vim81' } # Vim will not run if it is not within folder vim81
}

$pp = Get-PackageParameters
if ($pp['RestartExplorer'] -eq 'true') {
	Write-Debug "Restarting Explorer"
	Get-Process explorer | Stop-Process -Force
}

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
Start-ChocolateyProcessAsAdmin "-create-batfiles vim gvim evim view gview vimdiff gvimdiff -install-popup -install-openwith -add-start-menu" "$destDir\install.exe" -validExitCodes '0'
Remove-Item -Force -ea 0 "$toolsDir\*_x32.exe","$toolsDir\*_x64.exe"
Write-Output 'Build provided by TuxProject.de - consider donating to help support their server costs.'

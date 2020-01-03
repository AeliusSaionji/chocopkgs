$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$destDir = Join-Path $toolsDir "vim82"
if ($Env:ChocolateyPackageParameters -match '/InstallDir:\s*(.+)') {
	$destDir = $Matches[1]
	$destDir = $destDir -replace '^[''"]|[''"]$' # Strip quotations. Necessary?
	$destDir = $destDir -replace '[\/]$' # Remove any slashes from end of line
	if (-not ($destDir.EndsWith('vim82'))) { $destDir = Join-Path $destDir 'vim82' } # Vim will not run if it is not within folder vim82
}

$packageArgs = @{
	packageName = 'vim-tux.portable'
	filetype    = 'exe'
	file        = gi $toolsDir\*_x32.exe
	file64      = gi $toolsDir\*_x64.exe
	silentArgs  = "-o`"$destDir`" -y"
}

Install-ChocolateyPackage @packageArgs
(Get-Item $destdir\patch.exe).LastWriteTime = (Get-Date) # exe must be newer than manifest; Supplied manifest fixes useless UAC request
# Rather than letting the installer place the batch files in C:\WINDOWS, I have included them in this package.
# Installing them in this way ensures the package is compatible with non-admin installs, as a good portable package should :)
Get-ChildItem "$destDir\*.bat" | %{ Install-BinFile -Name $_.BaseName -Path $_ }
Remove-Item -Force -ea 0 "$toolsDir\*_x32.exe","$toolsDir\*_x64.exe"
Write-Host 'Build provided by TuxProject.de - consider donating to help support their server costs.'

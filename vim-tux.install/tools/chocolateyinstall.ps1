$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$destDir = Join-Path $ENV:ProgramFiles "Vim\vim80"
if ($Env:ChocolateyPackageParameters -match '/InstallDir:\s*(.+)') {
    $destDir = $Matches[1]
    if ($destDir.StartsWith("'") -or $destDir.StartsWith('"')) { $destDir = $destDir -replace '^.|.$' }
}
$filePath = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne $true) {
       Write-Host "Installing 64 bit version" ; gi $toolsDir\*_x64.7z }
else { Write-Host "Installing 32 bit version" ; gi $toolsDir\*_x32.7z }

$packageArgs = @{
        packageName      = 'vim-tux.install'
        file             = "$filePath"
        destination      = "$destDir"
}

Get-ChocolateyUnzip @packageArgs
Start-ChocolateyProcessAsAdmin "-create-batfiles vim gvim evim view gview vimdiff gvimdiff -install-popup -install-openwith -add-start-menu" "$destDir\install.exe" -validExitCodes '0'
Write-Output "Build provided by TuxProject.de - consider donating to help support their server costs."

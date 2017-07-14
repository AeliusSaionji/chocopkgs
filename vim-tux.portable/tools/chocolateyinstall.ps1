$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$destDir = Join-Path $toolsDir "vim80"
if ($Env:ChocolateyPackageParameters -match '/InstallDir:\s*(.+)') {
    $destDir = $Matches[1]
    if ($destDir.StartsWith("'") -or $destDir.StartsWith('"')) {
        $destDir = $destDir -replace '^.|.$' '' }
$filePath = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne $true) {
       Write-Host "Installing 64 bit version" ; gi $toolsDir\*_x64.7z }
else { Write-Host "Installing 32 bit version" ; gi $toolsDir\*_x32.7z }

$packageArgs = @{
        packageName      = 'vim-tux.portable'
        file             = "$filePath"
        destination      = "$destDir"
}

Get-ChocolateyUnzip @packageArgs
Get-ChildItem "$destDir\*.bat" | %{ Install-BinFile -Name $_.BaseName -Path $_ }
Start-Process "$destDir\install.exe" -ArgumentList "-add-start-menu" -WorkingDirectory "$destDir"
Write-Output "Build provided by TuxProject.de - consider donating to help support their server costs."

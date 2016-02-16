$packageName = 'vim-x64.install'
$tempFolder = "$ENV:TEMP\chocolatey\vim-x64.install"
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = "http://tuxproject.de/projects/vim/complete-x64.7z"
$url64 = $url

function Move-LockedFile { 
    param($path, $destination)

    $path = (Resolve-Path $path).Path 
    $destination = $executionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($destination)

    $MOVEFILE_DELAY_UNTIL_REBOOT = 0x00000004

    $memberDefinition = @’ 
    [DllImport("kernel32.dll", SetLastError=true, CharSet=CharSet.Auto)] 
    public static extern bool MoveFileEx(string lpExistingFileName, string lpNewFileName, 
       int dwFlags); 
‘@

    $type = Add-Type -Name MoveFileUtils -MemberDefinition $memberDefinition -PassThru 
    $type::MoveFileEx($path, $destination, $MOVEFILE_DELAY_UNTIL_REBOOT) 
}

# Remove traces of Veegee's Build
if ( (Get-ItemProperty -ErrorAction SilentlyContinue 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\Vim 7.4\').UninstallString -eq "$ENV:ProgramFiles\Vim\vim74\uninstall-gui.exe" ) {
 Write-Output "New build installs to ChocolateyLib. Removing from Program Files."
 Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Vim 7.4' -ErrorAction SilentlyContinue
 Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Vim_x64" -ErrorAction SilentlyContinue
 Move-LockedFile "$ENV:ProgramFiles\Vim" "$ENV:TEMP\veegeevim"
}

# Manually download and extract to temp
Get-ChocolateyWebFile $packageName $(Join-Path $tempFolder "vim.7z") $url $url64
Get-ChocolateyUnzip $(Join-Path $tempFolder "vim.7z") $(Join-Path $tempFolder "vim74")
# Remove this dll
Move-Item -Force $(Join-Path $tempFolder "vim74\GVimExt\gvimext.dll") $tempFolder
Move-Item -Force $(Join-Path $tempFolder "vim74\*") $(Join-Path $toolsDir "vim74")
# Fix file permissions
Start-Process icacls -ArgumentList "$toolsdir /reset /T /C /Q"
# Move the dll on reboot
Move-LockedFile $(Join-Path $tempFolder "gvimext.dll") $(Join-Path $toolsDir "vim74\GVimExt\gvimext.dll")
# See if the dll can go there now, let it fail if it can't
Copy-Item -Force $(Join-Path $tempFolder "gvimext.dll") $(Join-Path $toolsDir "vim74\GVimExt") -ErrorAction SilentlyContinue

Start-ChocolateyProcessAsAdmin "-create-batfiles evim view gview vimdiff gvimdiff -install-popup -install-openwith -add-start-menu" "$toolsDir\vim74\install.exe" -validExitCodes '0'

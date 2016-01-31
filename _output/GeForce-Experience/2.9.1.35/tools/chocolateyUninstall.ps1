$packageName = 'geforce-experience'
$softwareName = 'NVIDIA GeForce Experience*'
$PSChildName = '*Display.GFExperience' # Duplicate DisplayName exists
$installerType = 'EXE' 
#$silentArgs = '-silent' # RunDll32 NVI2.DLL
$validExitCodes = @(0)
$uninstalled = $false
$local_key     = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
$machine_key   = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*'
$machine_key6432 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'

[array]$key = Get-ItemProperty -Path @($machine_key6432,$machine_key, $local_key) `
                        -ErrorAction SilentlyContinue `
         | ? { ($_.DisplayName -like "$softwareName") -and ($_.PSChildName -like "$PSChildName") }

if ($key.Count -eq 1) {
  Start-Process "RunDll32.exe" """C:\Program Files\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL"",UninstallPackage Display.GFExperience -silent"
# The above is a temporary measure, until chocolatey can work with it, or someone can show me how to get it to work with chocolatey
#  $key | % { 
#    $silentArgs = "$($_.UninstallString)"
#    $silentArgs = $silentArgs + " -silent"
#    $silentArgs = $silentArgs.Replace('"','""')
#    $file = 'RunDll32.exe'
#    Uninstall-ChocolateyPackage -PackageName $packageName `
#                                -FileType $installerType `
#                                -SilentArgs "$silentArgs" `
#                                -ValidExitCodes $validExitCodes `
#                                -File "$file"
#  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$key.Count matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | % {Write-Warning "- $_.DisplayName"}
}

$packageArgs = @{
    packageName    = 'geforce-experience'
    filetype       = 'EXE'
    url            = 'https://us.download.nvidia.com/GFE/GFEClient/3.21.0.33/GeForce_Experience_v3.21.0.33.exe'
    checksum       = '3c222fe4b67f433fed0738f7a3756582eadbb6c7b05de8e4de1020904414e668'
    checksumType   = 'sha256'
    silentArgs     = '-s -noreboot'
    validExitCodes = @(0)
    softwareName   = 'NVIDIA Geforce Experience*'
}

Install-ChocolateyPackage @packageArgs

Write-Host "If you experience errors after updating, you may need to reboot."

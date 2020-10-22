$packageArgs = @{
    packageName    = 'geforce-experience'
    filetype       = 'EXE'
    url            = 'https://us.download.nvidia.com/GFE/GFEClient/3.20.5.70/GeForce_Experience_v3.20.5.70.exe'
    checksum       = '289b0ea5e737734217830349d4b9e6c510aa01bdd7e765efc75342ce21be85e4'
    checksumType   = 'sha256'
    silentArgs     = '-s -noreboot'
    validExitCodes = @(0)
    softwareName   = 'NVIDIA Geforce Experience*'
}

Install-ChocolateyPackage @packageArgs

Write-Host "If you experience errors after updating, you may need to reboot."

$packageArgs = @{
    packageName    = 'geforce-experience'
    filetype       = 'EXE'
    url            = 'https://us.download.nvidia.com/GFE/GFEClient/3.18.0.94/GeForce_Experience_v3.18.0.94.exe'
    checksum       = 'a109409a0eec65de6658b75851f93c0c932a1b2d177615ba370e7e891b75ac66'
    checksumType   = 'sha256'
    silentArgs     = '-s -noreboot'
    validExitCodes = @(0)
    softwareName   = 'NVIDIA Geforce Experience*'
}

Install-ChocolateyPackage @packageArgs

Write-Output "If you experience errors after updating, you may need to reboot."

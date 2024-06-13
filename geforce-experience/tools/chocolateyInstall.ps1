$packageArgs = @{
    packageName    = 'geforce-experience'
    filetype       = 'EXE'
    url            = 'https://us.download.nvidia.com/GFE/GFEClient/3.28.0.417/GeForce_Experience_v3.28.0.417.exe'
    checksum       = '8dddb758d45f0f46bc2a9d71294a3625ea0c7f53174616b9935f8ac5064ad57e'
    checksumType   = 'sha256'
    silentArgs     = '-s -noreboot'
    validExitCodes = @(0)
    softwareName   = 'NVIDIA Geforce Experience*'
}

Install-ChocolateyPackage @packageArgs

Write-Host "If you experience errors after updating, you may need to reboot."

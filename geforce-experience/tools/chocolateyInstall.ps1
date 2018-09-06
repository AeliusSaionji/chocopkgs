$packageArgs = @{
    packageName    = 'geforce-experience'
    filetype       = 'EXE'
    url            = 'https://us.download.nvidia.com/GFE/GFEClient/3.14.1.48/GeForce_Experience_v3.14.1.48.exe'
    checksum       = 'd983d5e6b4cf6d42f50b08debd1ecbf6fe3760c73c30aa3477a209bdeda496f9'
    checksumType   = 'sha256'
    silentArgs     = '-s -noreboot'
    validExitCodes = @(0)
    softwareName   = 'NVIDIA Geforce Experience*'
}

Install-ChocolateyPackage @packageArgs

Write-Output "If you experience errors after updating, you may need to reboot."

$packageArgs = @{
    packageName = 'x264vfw'
    filetype    = 'EXE'
    file        = gi $toolsDir\*_x32.exe
    silentArgs  = "/S"
}

Install-ChocolateyPackage @packageArgs
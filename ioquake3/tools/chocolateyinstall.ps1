$packageName = 'ioquake3'
$version = '{{PackageVersion}}'
$url = "http://ioquake3.org/files/1.36/installer/ioquake3-1.36-3.1.x86.exe"
$urlDataInstaller = "http://ioquake3.org/files/1.36/data/ioquake3-q3a-1.32-1.x86.exe"
$checksum = '{{Checksum}}'
$checksumDataInstaller = '{{Checksumx64}}'
$checksumType  = 'md5'
$fileType = 'EXE'
$silentArgs = '/S' # NSIS
$validExitCodes= @(0)

Install-ChocolateyPackage $packageName $fileType $silentArgs $url -validExitCodes $validExitCodes -checksum $checksum -checksumType $checksumType
Install-ChocolateyPackage $packageName $fileType $silentArgs $urlDataInstaller -validExitCodes $validExitCodes -checksum $checksumDataInstaller -checksumType $checksumType

# Find ioquake3 folder
$local_key     = 'HKCU:\Software\*'
$machine_key   = 'HKLM:\SOFTWARE\*'
$machine_key6432 = 'HKLM:\SOFTWARE\Wow6432Node\*'
[array]$instDirKey = Get-ItemProperty -Path @($machine_key6432,$machine_key, $local_key) `
                        -ErrorAction SilentlyContinue `
         | ? { $_.Install_Dir -like "*ioquake3" }
$baseq3Dir = Join-Path $instDirKey.Install_Dir "baseq3"
$missionDir = Join-Path $instDirKey.Install_Dir "missionpack"

# Find pak0 from existing Steam quake3 installation
$local_key     = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
$machine_key   = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*'
$machine_key6432 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
[array]$steamDir = Get-ItemProperty -Path @($machine_key6432,$machine_key, $local_key) `
                        -ErrorAction SilentlyContinue `
         | ? { $_.DisplayName -like "Quake III Arena" }
$pakPath = Join-Path $steamDir.InstallLocation "baseq3\pak0.pk3"
$pakTAPath = Join-Path $steamDir.InstallLocation "missionpack\pak0.pk3"
Copy-Item $pakPath $baseq3Dir -ErrorAction SilentlyContinue
Copy-Item $pakTAPath $missionDir -ErrorAction SilentlyContinue

# Find pak0 from existing GOG quake3 installation
$local_key     = 'HKCU:\Software\GOG.com\Games\*'
$machine_key   = 'HKLM:\SOFTWARE\GOG.com\Games\*'
$machine_key6432 = 'HKLM:\SOFTWARE\Wow6432Node\GOG.com\Games\*'
[array]$gogDir = Get-ItemProperty -Path @($machine_key6432,$machine_key, $local_key) `
                        -ErrorAction SilentlyContinue `
         | ? { $_.GAMENAME -like "Quake III Gold" }
$pakPath = Join-Path $gogDir.PATH "baseq3\pak0.pk3"
$pakTAPath = Join-Path $gogDir.PATH "missionpack\pak0.pk3"
Copy-Item $pakPath $baseq3Dir -ErrorAction SilentlyContinue
Copy-Item $pakTAPath $missionDir -ErrorAction SilentlyContinue

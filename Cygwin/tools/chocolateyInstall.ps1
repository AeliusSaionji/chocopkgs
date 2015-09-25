$packageName = 'Cygwin'
$url = 'http://cygwin.com/setup-x86.exe'
$url64 = 'http://cygwin.com/setup-x86_64.exe'
$installerType = 'exe'
$silentArgs = '--no-admin --quiet-mode -g -d -o -l c:\cygwin64\tmp -P irssi,openssh,curl,rsync,zsh,git,make,perl-Text-CharWidth,perl-Algorithm-Diff -s http://mirrors.kernel.org/sourceware/cygwin/'
Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64

Import-Module au

. $PSScriptRoot\..\geforce-game-ready-driver\update.ps1

# Left empty intentionally
# Checksums provided by geforce-game-ready-driver
function global:au_BeforeUpdate { }
function global:au_SearchReplace {
	@{
		".\nvidia-display-driver.nuspec" = @{
			"(?i)(^\s*<releaseNotes>)(.*)" = "`${1}http://us.download.nvidia.com/Windows/$($Latest.Version)/$($Latest.Version)-win10-win8-win7-desktop-release-notes.pdf</releaseNotes>"
		}
	}
}

Update-Package -ChecksumFor none
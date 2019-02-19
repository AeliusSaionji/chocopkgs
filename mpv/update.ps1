Import-Module au

. $PSScriptRoot\..\mpv.install\update.ps1

function global:au_SearchReplace {
	@{
		"$($Latest.PackageName).nuspec" = @{
			"(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"$($Latest.Version)`""
			"(?i)(^\s*<releaseNotes>)(.*)" = "`${1}https://https://mpv.srsfckn.biz/changes/$($Latest.CHANGES)/</releaseNotes>"
		}
	}
}

# Left empty intentionally
function global:au_BeforeUpdate { }

Update-Package -ChecksumFor none

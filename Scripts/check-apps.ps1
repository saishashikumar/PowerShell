﻿<#
.SYNOPSIS
	Query application details
.DESCRIPTION
	This PowerShell script queries application details and list it.
.EXAMPLE
	PS> ./check-apps
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		# TODO
	} else {
		Write-Progress "⏳ (1/2) Querying installed applications..."
		$NumAppsInstalled = (Get-AppxPackage).Count

		Write-Progress "⏳ (2/2) Querying available updates..."
		$NumUpdates = (winget upgrade).Count - 5
		"✅ $NumAppsInstalled apps installed, $NumUpdates updates available"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
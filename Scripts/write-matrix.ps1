<#
.SYNOPSIS
        Writes the matrix
.DESCRIPTION
        This PowerShell script writes the animated Matrix.
.EXAMPLE
        PS> ./write-fractal
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

function CalculateMatrix { param([int]$Pos, [char]$Letter)
	[int]$maxx = $rui.MaxWindowSize.Width
	[int]$maxy = $rui.MaxWindowSize.Height
	[int]$y = 0
	for ([int]$x = 0; $x -lt $maxx; $x++) {
		if ($x -eq $Pos) {
			$global:buf[$y * $maxx + $x] = $Letter
		} else {
			$global:buf[$y * $maxx + $x] = [char]32
		}
	}
	for ([int]$y = ($maxy - 1); $y -gt 0; $y--) { 
		for ([int]$x = 0; $x -lt $maxx; $x++) { 
			$global:buf[$y * $maxx + $x] = $global:buf[($y - 1) * $maxx + $x]
		} 
	}
}

function NextLetter {
	if ($global:index -eq 6) { $global:index = 0; $global:pos = [int]$global:generator.next(0, $rui.MaxWindowSize.Width) }
	switch($global:index++) {
	0 { return 'X' }
	1 { return 'I' }
	2 { return 'R' }
	3 { return 'T' }
	4 { return 'A' }
	5 { return 'M' }
	}
}

$ui = (Get-Host).ui
$rui = $ui.rawui
$buffer0 = ""
1..($rui.MaxWindowSize.Width * $rui.MaxWindowSize.Height) | ForEach-Object { $buffer0 += " " }
$global:buf = $buffer0.ToCharArray()
$global:generator = New-Object System.Random
$global:pos = [int]$global:generator.next(0, $rui.MaxWindowSize.Width)
$global:index = 0

while ($true) {	
	$Letter = NextLetter
	CalculateMatrix $global:pos $Letter
	[console]::SetCursorPosition(0,0)
	[string]$Screen = New-Object system.string($global:buf, 0, $global:buf.Length)
	Write-Host -foreground green $Screen -noNewline
}
exit 0 # success
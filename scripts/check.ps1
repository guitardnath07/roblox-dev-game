# « Tout vérifier » : lint (selene), format (stylua --check), build Rojo.
# Usage : powershell -ExecutionPolicy Bypass -File scripts/check.ps1
$ErrorActionPreference = "Stop"
Set-Location (Split-Path $PSScriptRoot -Parent)

$failed = @()
function Step($name, [scriptblock]$cmd) {
	Write-Host "== $name" -ForegroundColor Cyan
	& $cmd
	if ($LASTEXITCODE -ne 0) { $script:failed += $name }
}

Step "selene" { selene src }
Step "stylua" { stylua --check src }
$out = Join-Path $env:TEMP "dino-dice-check.rbxl"
Step "rojo build" { rojo build default.project.json -o $out }

if ($failed.Count -gt 0) {
	Write-Host "ECHEC : $($failed -join ', ')" -ForegroundColor Red
	exit 1
}
Write-Host "Tout est OK." -ForegroundColor Green

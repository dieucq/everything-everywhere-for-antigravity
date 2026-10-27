[CmdletBinding()]
param([string]$TargetPluginsDir = (Join-Path $env:USERPROFILE '.gemini/config/plugins'))
$ErrorActionPreference = 'Stop'
if (-not (Test-Path -LiteralPath $TargetPluginsDir -PathType Container)) { throw "Missing plugin directory: $TargetPluginsDir" }
$result = @(foreach ($plugin in (Get-ChildItem -LiteralPath $TargetPluginsDir -Directory | Where-Object { $_.Name -notmatch '\.backup-' })) {
  $manifest = Join-Path $plugin.FullName 'plugin.json'
  $valid = $false
  if (Test-Path -LiteralPath $manifest -PathType Leaf) {
    try { $null = Get-Content -LiteralPath $manifest -Raw | ConvertFrom-Json; $valid = $true } catch {}
  }
  $skillsDir = Join-Path $plugin.FullName 'skills'
  $count = if (Test-Path -LiteralPath $skillsDir -PathType Container) {
    @(Get-ChildItem -LiteralPath $skillsDir -Filter SKILL.md -File -Recurse).Count
  } else { 0 }
  [pscustomobject]@{ Plugin=$plugin.Name; ManifestValid=$valid; SkillEntrypoints=$count }
})
$result | Format-Table -AutoSize
Write-Host "Plugin folders: $($result.Count). File count is NOT proof of runtime registration."
Write-Host 'IDE smoke test: ask agent to name the exact SKILL.md path used for a focused debugging task.'
if (@($result | Where-Object { -not $_.ManifestValid }).Count) { exit 1 }

# Install explicit, selected root skills into the official Antigravity IDE global skills location.
# This is separate from plugin deployment; preserve existing plugin installations.
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
 [string]$TargetSkillsDir = (Join-Path $env:USERPROFILE '.gemini/config/skills'),
 [string[]]$Names = @('brainstorming','writing-plans','executing-plans','systematic-debugging','verification-before-completion','smart-test','code-review-skill','database-design'),
 [switch]$NoBackup
)
$ErrorActionPreference='Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$sourceRoot = Join-Path $repoRoot 'skills'
if (-not (Test-Path -LiteralPath $sourceRoot -PathType Container)) { throw "Missing skills directory: $sourceRoot" }
if (@($Names).Count -eq 0) { throw 'Select at least one skill.' }
$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
foreach ($name in ($Names | Select-Object -Unique)) {
 if ($name -notmatch '^[a-z0-9][a-z0-9-]*$') { throw "Invalid skill name: $name" }
 $src = Join-Path $sourceRoot $name
 $entry = Join-Path $src 'SKILL.md'
 if (-not (Test-Path -LiteralPath $entry -PathType Leaf)) { throw "Skill missing SKILL.md: $name" }
}
foreach ($name in ($Names | Select-Object -Unique)) {
 $src = Join-Path $sourceRoot $name
 $dest = Join-Path $TargetSkillsDir $name
 if ($PSCmdlet.ShouldProcess($dest,"Install selected skill $name")) {
  New-Item -ItemType Directory -Path $TargetSkillsDir -Force | Out-Null
  if (Test-Path -LiteralPath $dest) {
   if (-not $NoBackup) {
    $backup = "$dest.backup-$stamp"
    Copy-Item -LiteralPath $dest -Destination $backup -Recurse -Force
    Write-Host "Backup: $backup"
   }
   Remove-Item -LiteralPath $dest -Recurse -Force
  }
  Copy-Item -LiteralPath $src -Destination $dest -Recurse -Force
  Write-Host "Installed: $name"
 }
}
Write-Host 'Verify runtime recognition in Antigravity Customizations and with /skill-name.'

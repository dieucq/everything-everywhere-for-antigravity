# Opt-in safer alternative to the original installer.
# File copying does not guarantee Antigravity runtime skill registration.
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
  [string]$TargetPluginsDir = (Join-Path $env:USERPROFILE '.gemini/config/plugins'),
  [string[]]$PluginNames = @(),
  [switch]$NoBackup
)
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$source = Join-Path $root 'plugins'
if (-not (Test-Path -LiteralPath $source -PathType Container)) { throw "Missing repository plugins: $source" }
$plugins = @(Get-ChildItem -LiteralPath $source -Directory)
if ($PluginNames.Count) {
  $unknown = @($PluginNames | Where-Object { $_ -notin $plugins.Name })
  if ($unknown.Count) { throw "Unknown plugins: $($unknown -join ', ')" }
  $plugins = @($plugins | Where-Object { $_.Name -in $PluginNames })
}
if (-not $plugins.Count) { throw 'No plugins selected' }
$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
foreach ($plugin in $plugins) {
  $dest = Join-Path $TargetPluginsDir $plugin.Name
  if ($PSCmdlet.ShouldProcess($dest, "Replace plugin $($plugin.Name)")) {
    New-Item -ItemType Directory -Path $TargetPluginsDir -Force | Out-Null
    if (Test-Path -LiteralPath $dest) {
      if (-not $NoBackup) {
        $backup = "$dest.backup-$stamp"
        Copy-Item -LiteralPath $dest -Destination $backup -Recurse -Force
        Write-Host "Backed up: $backup"
      }
      Remove-Item -LiteralPath $dest -Recurse -Force
    }
    Copy-Item -LiteralPath $plugin.FullName -Destination $dest -Recurse -Force
    Write-Host "Installed: $($plugin.Name)"
  }
}
Write-Host 'Copy complete. Run Test-AntigravityInstallation.ps1 and verify inside Antigravity.'

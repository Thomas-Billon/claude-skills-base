# INFO: Creates a junction in %USERPROFILE%\.claude\skills for each skill of the repo (folder containing a SKILL.md).
# Idempotent: existing junctions are kept, those pointing elsewhere are reported.

$skillsDirectory = Join-Path $env:USERPROFILE '.claude\skills'
New-Item -ItemType Directory -Force -Path $skillsDirectory | Out-Null

Get-ChildItem -Path $PSScriptRoot -Directory |
    Where-Object { Test-Path (Join-Path $_.FullName 'SKILL.md') } |
    ForEach-Object {
        $linkPath = Join-Path $skillsDirectory $_.Name

        if (-not (Test-Path $linkPath)) {
            New-Item -ItemType Junction -Path $linkPath -Target $_.FullName | Out-Null
            Write-Host "Created: $($_.Name)"
            return
        }

        $currentTarget = (Get-Item $linkPath).Target
        if ($currentTarget -eq $_.FullName) {
            Write-Host "Present: $($_.Name)"
        } else {
            Write-Warning "$($_.Name) already exists but points to '$currentTarget' instead of '$($_.FullName)'"
        }
    }

# INFO: Creates %USERPROFILE%\.claude\CLAUDE.md, a relay that imports the CLAUDE.md of the repo.
# A file symlink would require admin rights, hence the Claude Code import instead.
# Idempotent: a correct relay is kept, a different CLAUDE.md is reported and left untouched.

$repoClaudeMdPath = Join-Path $PSScriptRoot 'CLAUDE.md'
$globalClaudeMdPath = Join-Path $env:USERPROFILE '.claude\CLAUDE.md'
$relayContent = '@' + ($repoClaudeMdPath -replace '\\', '/')

# INFO: The base repo ships no CLAUDE.md, global rules are personal: an empty one is created on first install.
if (-not (Test-Path $repoClaudeMdPath)) {
    [System.IO.File]::WriteAllText($repoClaudeMdPath, '')
    Write-Host "Created: CLAUDE.md (empty, in the repo)"
}

if (-not (Test-Path $globalClaudeMdPath)) {
    [System.IO.File]::WriteAllText($globalClaudeMdPath, "$relayContent`n")
    Write-Host "Created: CLAUDE.md (relay)"
} elseif ((Get-Content -Raw $globalClaudeMdPath).Trim() -eq $relayContent) {
    Write-Host "Present: CLAUDE.md (relay)"
} else {
    Write-Warning "$globalClaudeMdPath already exists with a different content: merge it into the CLAUDE.md of the repo, delete it, then run the script again"
}

# INFO: Adds the base repo as the upstream remote, to merge its updates. Skipped when the repo is the base itself.
# Idempotent: a correct upstream is kept, an upstream pointing elsewhere is reported and left untouched.

$baseRepoUrl = 'https://github.com/Thomas-Billon/claude-skills-base.git'
$originUrl = git -C $PSScriptRoot remote get-url origin 2>$null
$upstreamUrl = git -C $PSScriptRoot remote get-url upstream 2>$null

if ($originUrl -eq $baseRepoUrl) {
    Write-Host "Skipped: upstream remote (this repo is the base)"
} elseif (-not $upstreamUrl) {
    git -C $PSScriptRoot remote add upstream $baseRepoUrl
    Write-Host "Created: upstream remote"
} elseif ($upstreamUrl -eq $baseRepoUrl) {
    Write-Host "Present: upstream remote"
} else {
    Write-Warning "upstream remote already exists but points to '$upstreamUrl' instead of '$baseRepoUrl'"
}

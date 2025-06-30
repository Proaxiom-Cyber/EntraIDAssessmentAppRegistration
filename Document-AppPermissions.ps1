param(
    [string]$TenantId,
    [string]$ReadmePath = (Join-Path $PSScriptRoot 'README.md')
)

# Scopes required only to read service-principal metadata
$Scopes = @('Application.Read.All')

# ---- Connect to Microsoft Graph ----
if ($TenantId) {
    Connect-MgGraph -TenantId $TenantId -Scopes $Scopes -NoWelcome
} else {
    Connect-MgGraph -Scopes $Scopes -NoWelcome
}

# ------------------------------------
# Dynamically extract the CSV block from Add-ProaxiomCyberAppRegistration.ps1
$addScriptPath = Join-Path $PSScriptRoot 'Add-ProaxiomCyberAppRegistration.ps1'
if (-not (Test-Path $addScriptPath)) {
    throw "Could not locate Add-ProaxiomCyberAppRegistration.ps1 in $PSScriptRoot"
}

$fileContent = Get-Content $addScriptPath -Raw
$startToken = "`$csvData = @'"
$endToken   = "'@"

$startIndex = $fileContent.IndexOf($startToken)
if ($startIndex -lt 0) { throw 'Failed to locate start of CSV data block.' }
$remainder  = $fileContent.Substring($startIndex + $startToken.Length)
$endIndex   = $remainder.IndexOf($endToken)
if ($endIndex -lt 0) { throw 'Failed to locate end of CSV data block.' }

$csvData = $remainder.Substring(0, $endIndex).Trim()

$permissionsList = $csvData | ConvertFrom-Csv

function Get-AppPermissionLookupTable {
    param(
        [Parameter(Mandatory)]
        [psobject]$PermissionCsv
    )

    $lookups = [System.Collections.Generic.List[object]]::new()
    $spCache = @{}

    foreach ($perm in $PermissionCsv) {
        if (-not $spCache.ContainsKey($perm.ResourceAppId)) {
            $spCache[$perm.ResourceAppId] = Get-MgServicePrincipal -Filter "appId eq '$($perm.ResourceAppId)'" -Property displayName,appRoles,oauth2PermissionScopes
        }

        $sp = $spCache[$perm.ResourceAppId]
        $collection = if ($perm.AccessType -eq 'Scope') { $sp.oauth2PermissionScopes } else { $sp.appRoles }
        $permissionMeta = $collection | Where-Object Id -eq $perm.PermissionId

        if ($permissionMeta) {
            $lookups.Add([pscustomobject]@{
                API         = $sp.displayName
                Permission  = $permissionMeta.Value
                Type        = $perm.AccessType
                GUID        = $perm.PermissionId
                Description = (
                    ($permissionMeta.Description -as [string]) -replace '(?i)\bwithout\b[^\.]*signed[- ]in\s+user\.?', ''
                ).Trim()
            })
        } else {
            Write-Warning "Could not resolve $($perm.PermissionId)"
        }
    }

    $mdHeader = '| API | Permission | Type | GUID | Description |'
    $mdSep    = '| --- | ---------- | ---- | ---- | ----------- |'
    $mdRows   = $lookups | Sort-Object API,Permission | ForEach-Object {
        '| ' + ($_.API -replace '\|','\\|') + ' | ' + ($_.Permission -replace '\|','\\|') + ' | ' + $_.Type + ' | ' + $_.GUID + ' | ' + ($_.Description -replace '\|','\\|') + ' |'
    }
    return @($mdHeader,$mdSep) + $mdRows
}

$tableLines = Get-AppPermissionLookupTable -PermissionCsv $permissionsList

$startMarker = '<!-- PERMISSIONS-TABLE-START -->'
$endMarker   = '<!-- PERMISSIONS-TABLE-END -->'

if (Test-Path $ReadmePath) {
    $readmeContent = Get-Content $ReadmePath -Raw
} else {
    $readmeContent = ''
}

if ($readmeContent -match "$startMarker[\s\S]*?$endMarker") {
    $readmeContent = [regex]::Replace($readmeContent, "$startMarker[\s\S]*?$endMarker", "$startMarker`n$($tableLines -join "`n")`n$endMarker")
} else {
    $readmeContent += "`n`n$startMarker`n$($tableLines -join "`n")`n$endMarker"
}

Set-Content $ReadmePath $readmeContent

Write-Host "Updated permissions table in README.md" -ForegroundColor Green
$tableLines | ForEach-Object { Write-Host $_ } 
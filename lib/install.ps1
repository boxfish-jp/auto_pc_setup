function installApp {
    param (
        [Parameter(Mandatory = $true)]
        [AppInfo]$appInfo
    )
    Write-Host "Installing $($appInfo.appName)..."
    try {
        $null = Start-Process -NoNewWindow -FilePath "winget" -ArgumentList "show $($appInfo.winget)" -Wait -PassThru
    }
    catch {
        Write-Error "Error: Package '$($appInfo.winget)' not found."
        return "not found"
    }
    try {
        $null = Start-Process -NoNewWindow -FilePath "winget" -ArgumentList "install -e --id $($appInfo.winget)" -Wait -PassThru
    }
    catch {
        Write-Error "Error: Failed to install package '$($appInfo.winget)'."
        return "failed"
    }
    return "installed"
}
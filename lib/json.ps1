class AppInfo {
    [int]$id
    [string]$appName
    [string]$status
    [string]$winget

    AppInfo([int]$id, [string]$appName, [string]$status, [string]$winget) {
        $this.id = $id
        $this.appName = $appName
        $this.status = $status
        $this.winget = $winget
    }

    [void]PrintDetails() {
        Write-Output "id: $($this.id), name: $($this.appName), status: $($this.status), winget: $($this.winget)"
    }
}

class JsonData {
    [string] $jsonFilePath

    JsonData([string] $jsonFilePath) {
        $this.jsonFilePath = $jsonFilePath
    }

    [array] getAppList() {
        if (-Not (Test-Path $this.jsonFilePath)) {
            Write-Error "Error: File '$($this.jsonFilePath)' not found."
            exit
        }

        # JSONファイルを読み込んでオブジェクトに変換
        try {
            $appList = Get-Content $this.jsonFilePath -Encoding Default | ConvertFrom-Json
        }
        catch {
            Write-Error "Failed to read JSON file."
            exit
        }

        # JSONオブジェクトをAppInfoクラスのインスタンスに変換
        $appInfoList = @()
        foreach ($item in $appList) {
            $appInfoList += [AppInfo]::new($item.id, $item.appName, $item.status, $item.winget)
        }
        return $appInfoList
    }

    [void] updateStatus([int] $id, [string] $status) {
        # JSONファイルを読み込んでオブジェクトに変換
        $appList = Get-Content $this.jsonFilePath -Encoding Default | ConvertFrom-Json

        # idが一致するデータを取得
        $targetData = $appList | Where-Object { $_.id -eq $id }

        # ステータスを更新
        $targetData.status = $status

        # JSONファイルに書き込み
        $appList | ConvertTo-Json | Set-Content $this.jsonFilePath -Encoding Default
    }
}
# output.jsonの内容を読み込む
$outputJson = Get-Content -Path "output.json" -Raw | ConvertFrom-Json

# app.jsonの内容を作成する
$appJson = @()
$id = 1

foreach ($package in $outputJson) {
    $app = @{
        id = $id
        appName = $package.PackageIdentifier
        status = "waiting"
        winget = $package.PackageIdentifier
    }
    $appJson += $app
    $id++
}

# app.jsonの内容をJSON形式に変換して保存する
$appJson | ConvertTo-Json -Depth 10 | Set-Content -Path "app.json"
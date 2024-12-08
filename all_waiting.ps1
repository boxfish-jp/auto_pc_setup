# JSONファイルのパスを指定
$jsonFilePath = "./app.json"

# JSONファイルを読み込む
$jsonContent = Get-Content -Path $jsonFilePath -Raw | ConvertFrom-Json

# 各オブジェクトのstatusをwaitingに変更
foreach ($app in $jsonContent) {
    $app.status = "waiting"
}

# 変更された内容をJSON形式に変換してファイルに保存
$jsonContent | ConvertTo-Json -Depth 32 | Set-Content -Path $jsonFilePath
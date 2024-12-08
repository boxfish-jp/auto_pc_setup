# スクリプトのディレクトリを取得
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

Set-Location $scriptDir

$filePath = "../app.json"
$outputFilePath = "./temp.js"

while ($true) {
    # ファイルの内容を読み込む
    $fileContent = Get-Content -Path $filePath -Raw

    # 先頭に "const appList=" を追記
    $newContent = "const appList=" + $fileContent

    if (-not (Test-Path -Path $outputFilePath)) {
        New-Item -Path $outputFilePath -ItemType File
    }

    # 新しい内容を別のファイルに書き込む
    Set-Content -Path $outputFilePath -Value $newContent

    # 1秒待機
    Start-Sleep -Seconds 1
}
# スクリプトのディレクトリを取得
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# 管理者権限があるかどうかを確認
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # 管理者権限がない場合は、管理者として再実行
    $arguments = "-NoProfile -ExecutionPolicy Bypass -File `"$scriptDir\main.ps1`""
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    exit
}

# スクリプトのディレクトリに移動
Set-Location $scriptDir

. ./lib/json.ps1
. ./lib/install.ps1

$jsonFilePath = "app.json"
$jsonData = [JsonData]::new($jsonFilePath)

$appList = $jsonData.getAppList()
Write-Output "$($appList.Length) apps found."

for ($i = 0; $i -lt $appList.Length; $i++) {
    $app = $appList[$i]
    if ($app.status -eq "waiting") {
        $status = installApp -appInfo $app
        $jsonData.updateStatus($app.id, $status)
    }
}

Write-Output "All process is done!"

# ユーザーにEnterキーを押させる
Read-Host -Prompt "Press Enter to exit"
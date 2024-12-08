# Auto_PC_Setup

wingetを使用し、アプリのインストール作業を自動化するスクリプトです。

## 使い方
1. wingetをインストールする
> win11ならデフォルトでインストールされているはず。

2. app.jsonを編集する
```json
{
    "apps": [
        {
            "id": 1,  // インストールするアプリの順番
            "appName": "Google Chrome",   // 任意のアプリ名(進捗確認をするときに使われます。)
            "status": "waiting",  // 監視アプリで使う変数なので、"waiting"にしてね。
            "winget":  "Google.Chrome",  // wingetのid https://winget.run/ などで調べよう。
        },
        {
            "id": 2,
            "appName": "Visual Studio Code",
            "status": "waiting",
            "winget":  "Microsoft.VisualStudioCode",
        }
    ]
}
```
3. main.ps1を実行する
```powershell
.\main.ps1
```

4. (オプション)監視アプリを実行する前準備
front_endフォルダにある、main.ps1を実行する。
```powershell
cd front_end
.\main.ps1
```

5. (オプション)監視アプリを実行する
index.htmlをブラウザで開く。

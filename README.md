# 環境変数の設定
1. ./aws-terraform配下に.envファイルを作成
2. 下記の環境変数を設定する(terraform用の環境変数準備)
```
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
```

# 新規に環境を作成する場合

1. 新しい環境のディレクトリ作成
```shell
make new_env NEW_ENV=new_env
```

2.環境の初期化の実行

3.デプロイ手順の実行

# 既存作成済み環境に変更を加える場合

1. terraform用のdockerの起動
```shell
$ make up
````

2. 環境の初期化の実行

3.デプロイ手順の実行

### 各環境の初期化
```shell
$ make init ENV={作成したい環境(ex: fukada)}
```

### デプロイ手順

1. SNS プラットフォームアプリケーション 作成時に必要になるplatform_credentialsとplatform_principalの生成

```shell
$ make platform_credentials FILE_PATH={p12ファイルの場所(~/~/Downloads/voip_cert.p12)} ENV={作成したい環境(ex: soneda)}
```

```shell
$ make platform_principal FILE_PATH={p12ファイルの場所(~/~/Downloads/voip_cert.p12)} ENV={作成したい環境(ex: soneda)}
```

2. terraformデプロイ実行planの確認
```shell
$ make plan ENV={実行したい環境(ex: soneda)} 
```

3. terraformデプロイ実行
```shell
$ make apply ENV={実行したい環境(ex: soneda)} 
```

# その他

### 環境の削除

```destroy
$ make destroy ENV={実行したい環境(ex: soneda)} 
```

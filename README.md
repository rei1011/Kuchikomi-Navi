# Kuchikomi-Navi

## 共通
devcontaienr間（backent - frontend）で通信するためにnetworkを作成
```
docker network create kuchikomi-network
```

## backend
### セットアップ
```
cd backend
(vs code上で) Rebuid and Reopen in Containerを実行 
rails db:create
```

### 起動
```
(container内で) rails s -b "0.0.0.0"
```

### API定義の出力
```
rails spec
（↑のコマンドがpassしたら） rails rswag:specs:swaggerize
```
上記コマンド実行後、[http://localhost:3000/api-docs](http://localhost:3000/api-docs)へアクセス

### rspecのデバッグ方法
デバッグしたい箇所に`binding.break`を記述し、
以下のコマンドを実行するとterminalにdebug consoleが表示される
```
rspec /path/to/test_spec.rb
```


## frontend
### yamlファイルからAPIの型定義を作成
```
yarn generate
```

## infra
### GCPのアカウントを作成
最初にGCPのアカウントを作成する

### gcloudの初期化
コンテナの初回起動時に自動でgcloudの初期化が実行される<br>
赤枠内に表示されているURLをブラウザで開き、ログインを行う<br>
最後に表示された確認コードを緑の枠に入力する
![alt text](./docs_image/image.png)
確認コードを入力後に、利用するprojectを選択する
![alt text](./docs_image/image2.png)

### 以下サービスのAdmin APIを有効化する
- Compute Engine
- Cloud RUN
有効化されるまでに数分かかります
![alt text](./docs_image/image3.png) 
![alt text](./docs_image/image6.png)

### tfstateファイルをTerraform Cloudに保存するために以下からアカウントを作成
https://app.terraform.io/public/signup/account

### terraform CLIで利用するtokenを設定
コンテナの初回起動時に自動でterraformの初期化が実行される<br>
以下に表示されるtokenをコピーし、terminalに貼り付ける<br>
![alt text](./docs_image/image4.png)

### Terraform Cloud経由でデプロイするためにGCPの認証情報を設定
gcloud初期化後に、`/root/.config/gcloud/application_default_credentials.json`に認証情報が保存されている<br>
Terraform Cloud経由でデプロイするためには、上記の情報が必要なため、下記のように登録する。<br>
必ず、<b>Sensitiveにはチェックを入れる</b>
| key | value |
| --- | ----- |
| gcp-creds | application_default_credentials.jsonの中身 |
![alt text](./docs_image/image5.png)

### Cloud Build経由でCloud Runへdeployするために、patを設定
[PATを作成](https://cloud.google.com/build/docs/automating-builds/github/connect-repo-github?hl=ja&generation=2nd-gen#connecting_a_github_host_programmatically:~:text=%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%81%97%E3%81%BE%E3%81%99%E3%80%82-,%E5%80%8B%E4%BA%BA%E7%94%A8%E3%81%AE,%E3%81%A6%E3%81%8F%E3%81%A0%E3%81%95%E3%81%84%E3%80%82,-%E5%80%8B%E4%BA%BA%E7%94%A8%E3%81%AE)し、以下のように登録する
| key | value |
| --- | ----- |
| gh-token | <PAT> |
![alt text](./docs_image/image5.png)

### リソースのデプロイ
```
./apply.sh
```

### リソースの削除
```
terraform destroy
```
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
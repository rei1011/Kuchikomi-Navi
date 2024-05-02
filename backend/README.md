# セットアップ
```
cd backend
(vs code上で) Rebuid and Reopen in Containerを実行 
rails db:create
```

# 起動
```
(container内で) rails server
```

# API定義の出力
```
rails spec
（↑のコマンドがpassしたら）rails rswag:specs:swaggerize
```
上記コマンド実行後、[http://localhost:3000/api-docs](http://localhost:3000/api-docs)へアクセス


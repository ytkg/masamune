# MASAMUNE

Twitterアカウント運用支援システム

<a href="https://www.ruby-lang.org/en/">
  <img src="https://img.shields.io/badge/Ruby-v2.6.6-green.svg" alt="ruby version">
</a>
<a href="http://rubyonrails.org/">
  <img src="https://img.shields.io/badge/Rails-v6.0.3.2-brightgreen.svg" alt="rails version">
</a>


## Git upstream の設定

```bash
$ git remote add upstream git@github.com:ytkg/masamune.git
$ git fetch upstream
$ git merge upstream/master
```

## 開発環境

必要なツール  

- git
- docker
- docker-compose

`docker-compose` を用いた初期化と起動  

```bash
## ビルド
$ docker-compose build
## JS 周りのライブラリをインストール
$ docker-compose run web yarn install
## DB周りの操作を実施
$ docker-compose run web rails db:create db:migrate db:seed
## 起動
$ docker-compose up -d
```

`postgres` に仮のテストデータを登録しておく  

```bash
## dbコンテナ postgresql へ接続
$ docker-compose run web rails db

## テーブル一覧
masamune_development=# \d
                  List of relations
 Schema |         Name          |   Type   |  Owner   
--------+-----------------------+----------+----------
 public | ar_internal_metadata  | table    | postgres
 public | schema_migrations     | table    | postgres
 public | tweets                | table    | postgres
 public | user_summaries        | table    | postgres
 public | user_summaries_id_seq | sequence | postgres
 public | users                 | table    | postgres
(6 rows)

## テストデータの登録
masamune_development-# INSERT INTO users VALUES (1, 'development_user_001', 0, 0, 0, 0, 0, 'false', '2020-03-01 00:00:00', '2020-03-01 00:00:00');
masamune_development-# INSERT INTO user_summaries VALUES (1, '2020-03-01', 1, 1, 1, '2020-03-01 00:00:00', '2020-03-01 00:00:00', 1, 1);
```

エラーが出ていないことを確認  

```bash
$ curl -X GET http://localhost:3000/
```

## 開発環境の更新

更新は下記の通り実施  

```bash
$ git fetch upstream
$ git merge upstream/master

$ docker-compose run web rails db:create db:migrate db:seed
```

## Herokuにデプロイする方法
```
# 最初に１回のみ実行
heroku create [applicatin name]
heroku config:add TZ=Asia/Tokyo
heroku config:set TWITTER_API_CONSUMER_KEY="TWITTER_API_CONSUMER_KEY"
heroku config:set TWITTER_API_CONSUMER_SECRET="TWITTER_API_CONSUMER_SECRET"
heroku config:set TWITTER_API_ACCESS_TOKEN="TWITTER_API_ACCESS_TOKEN"
heroku config:set TWITTER_API_ACCESS_TOKEN_SECRET="TWITTER_API_ACCESS_TOKEN_SECRET"
heroku config:set SLACK_WEBHOOK_URL="SLACK_WEBHOOK_URL"

git push heroku master
```

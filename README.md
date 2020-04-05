# MASAMUNE

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


## Git upstream の設定

```bash
$ git remote add upstream git@github.com:ytkg/masamune.git
$ git fetch upstream
$ git merge upstream/master
```

## 開発環境

必要なツール  

- git
- yarn
- docker
- docker-compose

`docker-compose` を用いた初期化と起動  

```bash
## JS 周りのライブラリをインストール
$ yarn install

## ビルド
$ docker-compose build
## DB周りの操作を実施
$ docker-compose run web bin/rake db:create db:migrate db:seed
## 起動
$ dokcer-compose up -d
```

`postgres` に仮のテストデータを登録しておく  

```bash
## dbコンテナへ接続
$ docker-compose exec db /bin/bash
## postgresql へ接続
# psql -U postgres masamune_development

## テーブル一覧
masamune_development-# \d
                  List of relations
 Schema |         Name          |   Type   |  Owner   
--------+-----------------------+----------+----------
 public | ar_internal_metadata  | table    | postgres
 public | schema_migrations     | table    | postgres
 public | trends                | table    | postgres
 public | trends_id_seq         | sequence | postgres
 public | tweets                | table    | postgres
 public | user_summaries        | table    | postgres
 public | user_summaries_id_seq | sequence | postgres
 public | users                 | table    | postgres
(8 rows)

## テストデータの登録
masamune_development-# INSERT INTO users VALUES (1, 'development_user_001', 0, 0, 0, 0, 0, 'false', '2020-03-01 00:00:00', '2020-03-01 00:00:00');
masamune_development-# INSERT INTO user_summaries VALUES (1, '2020-03-01', 1, 1, 1, '2020-03-01 00:00:00', '2020-03-01 00:00:00', 1, 1);
```

エラーが出ていないことを確認  

```bash
$ curl -X GET http://localhost:3000/
```

### 開発環境のエラー対応

事象: webコンテナが起動できなかった  

```bash
$ docker-compose logs web
...
web_1  | => Booting Puma
web_1  | => Rails 6.0.2.2 application starting in development 
web_1  | => Run `rails server --help` for more startup options
web_1  | warning Integrity check: System parameters don't match
web_1  | error Integrity check failed
web_1  | error Found 1 errors.
web_1  | 
web_1  | 
web_1  | ========================================
web_1  |   Your Yarn packages are out of date!
web_1  |   Please run `yarn install --check-files` to update.
web_1  | ========================================
web_1  | 
web_1  | 
web_1  | To disable this check, please change `check_yarn_integrity`
web_1  | to `false` in your webpacker config file (config/webpacker.yml).
web_1  | 
web_1  | 
web_1  | yarn check v1.13.0
web_1  | info Visit https://yarnpkg.com/en/docs/cli/check for documentation about this command.
web_1  | 
web_1  | 
web_1  | Exiting
```

`./config/webpacker.yml` の設定を変更した

```diff
...
- check_yarn_integrity: true
+ check_yarn_integrity: false
...
```

## 開発環境の更新

更新は下記の通り実施  

```bash
$ git fetch upstream
$ git merge upstream/master

$ docker-compose run web bin/rake db:create db:migrate db:seed
```

## Deployment on heroku
```
# One time only
heroku create [applicatin name]
heroku config:add TZ=Asia/Tokyo
heroku config:set TWITTER_API_CONSUMER_KEY="TWITTER_API_CONSUMER_KEY"
heroku config:set TWITTER_API_CONSUMER_SECRET="TWITTER_API_CONSUMER_SECRET"
heroku config:set TWITTER_API_ACCESS_TOKEN="TWITTER_API_ACCESS_TOKEN"
heroku config:set TWITTER_API_ACCESS_TOKEN_SECRET="TWITTER_API_ACCESS_TOKEN_SECRET"
heroku config:set SLACK_WEBHOOK_URL="SLACK_WEBHOOK_URL"

git push heroku master
heroku run rails db:migrate
```
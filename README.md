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

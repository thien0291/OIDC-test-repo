# README

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

* How to run the development server
- run `bundle install` to install all the required gems
- run `RAILS_ENV=development bundle exec rake assets:precompile` every time you make changes in `/assets`
- run `rails db:migrate`
- run `bin/dev` to start the development server

* ...


rails s -b 'ssl://localhost:3000?key=server.key&cert=server.crt'



PRESSINGLY_IDENTIFIER="Vm3O1AwPLPWChwBkWPW8FRSrDP_kuZjjOckqo6EtCzY" PRESSINGLY_SECRET="LkxKDuSUEUt6cGfafliSvIL-nWD2GMEbG-GuCqYZ9lQ" PRESSINGLY_REDIRECT_URL="https://localhost:3000/users/auth/openid_connect/callback" DEMO_IFRAME="https://preview.cruip.com/solid" SITE_TITLE="CTFLOW.IO" rails s  -b 'ssl://localhost:3005?key=server.key&cert=server.crt'

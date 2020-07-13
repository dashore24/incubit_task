# Incubit User Registration
## Dependencies
* Ruby version : 2.6.3
* Rails Version : 6.0.2
## Configuration
```gem install bundler && bundle install```
```yarn install```
## Setup and Start the Applicaton
### Database Setup
```rake db:create && rake db:migrate```
### Run the rails server
```rails s```
### Start sidekiq
``` bundle exec sidekiq -C config/sidekiq.yml```
## Test Environment Setup
### Test Database Setup
```RAILS_ENV=test rake db:create && RAILS_ENV=test rake db:migrate```
### Run the Test Suit
```rspec```
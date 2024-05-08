
## Installing Rspec
Rspec will automaticly create a factories directory when a new model is created e.g scaffold so don't create it manually. I used this guide but placed config.include FactoryBot::Syntax::Methods in the rails_helper.rb file.


## Sidekiq 
* Set up Sidekiq guide [here](https://railsnotes.xyz/blog/adding-redis-and-sidekiq-to-a-ruby-on-rails-app)

* Set up Sidekiq monitoring [here](https://github.com/sidekiq/sidekiq/wiki/Monitoring)

* Set up Procfile guide [here](https://railsnotes.xyz/blog/procfile-bin-dev-rails7)


#### TODO:
* Create a skeleton job to show that sidekiq is working
* > Follow up with a web scraper in a later commit

* Set up Procfile

* Clean up `config.include FactoryBot::Syntax::Methods`


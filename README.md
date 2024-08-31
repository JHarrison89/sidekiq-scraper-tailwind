
## Install Rspec & FactoryBot 
Rspec will automaticly create a factories directory when a new model is created e.g scaffold so don't create it manually. I used this guide but placed `config.include FactoryBot::Syntax::Methods` in the `rails_helper.rb` file.


## Sidekiq 
* Set up Sidekiq guide [here](https://railsnotes.xyz/blog/adding-redis-and-sidekiq-to-a-ruby-on-rails-app)

* Set up Sidekiq monitoring [here](https://github.com/sidekiq/sidekiq/wiki/Monitoring)

* Set up Procfile guide [here](https://railsnotes.xyz/blog/procfile-bin-dev-rails7)

* Reddit post about Sidekiq webscraper [here](spec/models/payment_confirmation_spec.rb)

* configure sidekiq thread pool [here](https://www.rubyguides.com/2015/07/ruby-threads/)

## Configuring emails 
* https://www.louisramos.dev/blogs/send-mail-on-rails-7-with-gmail


#### Rails credentials VS .ENVS
* https://thoughtbot.com/blog/switching-from-env-files-to-rails-credentials
I had to recreate my credentials.yml and master key: `rm config/credentials.yml.enc EDITOR="code --wait" bin/rails credentials:edit`


Sending emails with Sidekiq 
Because we've installed Sidekiq as our jobs queue, we use to it send emails. 
Sidekiq needed to be restarted to pick up the new SMTP configs before it could send emails.

> If you made changes to your email configuration (like SMTP settings) or to the job itself, Sidekiq might not pick up those changes until it is restarted. Sidekiq loads the application code when it starts, so any updates to the code or environment variables might require a restart to take effect.

https://www.codewithjason.com/restart-sidekiq-automatically-deployment/


#### TODO:
* Create a skeleton job to show that sidekiq is working
* > Follow up with a web scraper in a later commit

* Set up Procfile

* Clean up `config.include FactoryBot::Syntax::Methods`


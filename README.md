## TODO - Document project setup e.g tailwind, importmaps etc
- look at early commits


## Install Rspec & FactoryBot 
Rspec will automaticly create a factories directory when a new model is created e.g scaffold so don't create it manually. I used this guide but placed `config.include FactoryBot::Syntax::Methods` in the `rails_helper.rb` file.

## Configuring Procfile
* [here](https://railsnotes.xyz/blog/procfile-bin-dev-rails7)

## Install Sidekiq 
* Set up Sidekiq guide [here](https://railsnotes.xyz/blog/adding-redis-and-sidekiq-to-a-ruby-on-rails-app)

* Set up Sidekiq monitoring [here](https://github.com/sidekiq/sidekiq/wiki/Monitoring)

* Reddit post about Sidekiq webscraper [here](spec/models/payment_confirmation_spec.rb)

* configure sidekiq thread pool [here](https://www.rubyguides.com/2015/07/ruby-threads/)

## Configure emails 
* https://www.louisramos.dev/blogs/send-mail-on-rails-7-with-gmail


#### Rails credentials VS .ENVS
* https://thoughtbot.com/blog/switching-from-env-files-to-rails-credentials

I had to recreate my credentials.yml and master key: `rm config/credentials.yml.enc EDITOR="code --wait" bin/rails credentials:edit`


Sending emails with Sidekiq 
Because we've installed Sidekiq as our jobs queue, we use to it send emails. 
Sidekiq needed to be restarted to pick up the new SMTP configs before it could send emails.

> If you made changes to your email configuration (like SMTP settings) or to the job itself, Sidekiq might not pick up those changes until it is restarted. Sidekiq loads the application code when it starts, so any updates to the code or environment variables might require a restart to take effect.

* https://www.codewithjason.com/restart-sidekiq-automatically-deployment/

## Configure Heroku 
- https://devcenter.heroku.com/articles/getting-started-with-rails7#create-a-welcome-page
- - Run `bundle lock --add-platform x86_64-linux` to configure OS

##### Buildpacks 
Add `Chrome for testing` buildpack so watir gem can run headless chrome 
- https://github.com/heroku/heroku-buildpack-chrome-for-testing

#### Add-ons 
Add Heroku redis (free alternatives in judoscale link below)
- https://elements.heroku.com/addons/heroku-redis#pricing

##### Configure Sidekiq in production
Documentation is not good for this process, I pieced together these steps using these guide, AI, and lots of google searches. 

- https://gist.github.com/efrapp/1290af276c55086a40c92a3bef9573b5
- https://www.dennisokeeffe.com/blog/2022-03-04-getting-started-with-sidekiq-in-rails-7

- Create sidekiq initializer
  - Guide https://github.com/sidekiq/sidekiq/wiki/Using-Redis   
  - My file config/initializers/sidekiq.rb
    - My verison is from Claude.ai and includes REDIS_URL for production and (I think?) falls back to local here config/cable.yml
  - Deploy and monitor logs for feedback, /sidekiq dashboard will only work if setup correctly.
       
- Create a Procfile
  - spesify web & worker processes
  - Procfile MUST be capitalised
  - After deploying, web & worker processes should show in Heroku resourses
  - Check logs for confirmation of Heroku using Procfile
 
- Scale up (turn on) worker process 
  - If the work process is not displayed in Heroku resources after deplying Procfile, run below commands
  - heroku ps:scale web=1
  - heroku ps:scale worker=1
    - Don't forget to scale down worker after use otherwise it will run 24/7 and use eco dyno hours - see judoscale link for more info 

- USeful guide to heroku eco dynos
  - https://judoscale.com/blog/heroku-free-dynos


### Configure DataDog
- I set up basic DataDog following step in the official doc below; other guide is useful as a reference

- Official docs [https://docs.datadoghq.com/agent/guide/heroku-ruby/#sidekiq](https://docs.datadoghq.com/agent/guide/heroku-ruby/#prerequisites)
- - Postgres integration, links out to  [buildpack documentation](https://docs.datadoghq.com/agent/basic_agent_usage/heroku/#enabling-integrations), this seems to contain steps on more detailed intergrations. 
- Other guide https://danielabaron.me/blog/datadog-heroku-rails/#install-buildpack
- Sidekiq monitoring [not available on free plan](https://docs.datadoghq.com/agent/guide/heroku-ruby/#sidekiq)


????
Do I need this in production? test and remove...
- - heroku config:set REDIS_PROVIDER=REDISCLOUD_URL
????


#### TODO:
* Create a skeleton job to show that sidekiq is working
* > Follow up with a web scraper in a later commit

* Set up Procfile

* Clean up `config.include FactoryBot::Syntax::Methods`


## TODO - 
- Document project setup e.g tailwind, importmaps etc
- - look at early commits
- Clean up `config.include FactoryBot::Syntax::Methods`


## Install Rspec & FactoryBot 
Rspec will automaticly create a factories directory when a new model is created e.g scaffold so don't create it manually. I used this guide but placed `config.include FactoryBot::Syntax::Methods` in the `rails_helper.rb` file.

## Configure Procfile
* [here](https://railsnotes.xyz/blog/procfile-bin-dev-rails7)

## Install Sidekiq 
* Set up Sidekiq guide [here](https://railsnotes.xyz/blog/adding-redis-and-sidekiq-to-a-ruby-on-rails-app)

* Set up Sidekiq monitoring [here](https://github.com/sidekiq/sidekiq/wiki/Monitoring)

* configure sidekiq thread pool [here](https://www.rubyguides.com/2015/07/ruby-threads/)

## Rails Credentials
I decided to try Rails credentials for this project
* https://thoughtbot.com/blog/switching-from-env-files-to-rails-credentials

I had to recreate my credentials.yml and master key:
 `rm config/credentials.yml.enc EDITOR="code --wait" bin/rails credentials:edit`

## Sending emails 
* https://www.louisramos.dev/blogs/send-mail-on-rails-7-with-gmail


#### Sending emails with Sidekiq 
Because we've installed Sidekiq, ActionMailer sends our emails to Sidekiq to be dispatched. Restart Sidekiq to pick up new configuration settings like SMTP configs.

> If you made changes to your email configuration (like SMTP settings) or to the job itself, Sidekiq might not pick up those changes until it is restarted. Sidekiq loads the application code when it starts, so any updates to the code or environment variables might require a restart to take effect.

* https://www.codewithjason.com/restart-sidekiq-automatically-deployment/

## Configure Heroku 
- https://devcenter.heroku.com/articles/getting-started-with-rails7#create-a-welcome-page

### IMPORTANT HEROKU API TOKEN NOTE
Many hard to diagnose bugs occure due to an invalid Heroku API Token.
Skip the headach and generate a non-expiring token by running
 `heroku authorizations:create`. 

Its worth double checking the token is correct from time to time to avoild issues.
 - https://devcenter.heroku.com/articles/platform-api-quickstart#authentication


#### Add platform to Gemfile.lock
 Run `bundle lock --add-platform x86_64-linux` to configure OS

#### Buildpacks 
Add `Chrome for testing` buildpack so Watir/Selineum/Ferrum can run headless chrome
- https://github.com/heroku/heroku-buildpack-chrome-for-testing

#### Add-ons 
Add Heroku redis (free alternatives in judoscale link below)
- https://elements.heroku.com/addons/heroku-redis#pricing
- https://elements.heroku.com/addons/heroku-postgresql
- https://elements.heroku.com/addons/scheduler

## Configure Sidekiq in production
Documentation is not great.
I pieced together these steps using the links below, AI, and lots of google searches. 

- https://gist.github.com/efrapp/1290af276c55086a40c92a3bef9573b5
- https://www.dennisokeeffe.com/blog/2022-03-04-getting-started-with-sidekiq-in-rails-7

#### Create sidekiq initializer
  - https://github.com/sidekiq/sidekiq/wiki/Using-Redis   
  - Reference `config/initializers/sidekiq.rb`

My verison is from Claude.ai and includes REDIS_URL for production and (I think?) falls back to local here config/cable.yml

Deploy to Heroku and monitor logs (or Bugsnag) for feedback. The sidekiq dashboard will only work if setup correctly.
       
#### Create a Procfile
  - spesify web & worker processes
  - Procfile file name **must** be capitalised
  - After deploying, web & worker processes show in Heroku
  - Check logs for confirmation of Heroku using Procfile
 
#### Scale up (turn on) worker process 
If the work process is not running in Heroku resources after deplying Procfile, run below commands
  - heroku ps:scale web=1 
  - heroku ps:scale worker=1

Don't forget to scale down workers, otherwise they run 24/7 and use eco dyno hours

#### Useful guide to heroku eco dynos
  - https://judoscale.com/blog/heroku-free-dynos


## Configure DataDog
Use the office guide to basic DataDog following step in the official doc below; other guide is useful as a reference

#### Official docs 
[https://docs.datadoghq.com/agent/guide/heroku-ruby/#sidekiq](https://docs.datadoghq.com/agent/guide/heroku-ruby/#prerequisites)
- Postgres integration, links out to  [buildpack documentation](https://docs.datadoghq.com/agent/basic_agent_usage/heroku/#enabling-integrations) this seems to contain steps on more detailed intergrations. 

#### Other guide 
https://danielabaron.me/blog/datadog-heroku-rails/#install-buildpack

#### Sidekiq monitoring not available on free plan
https://docs.datadoghq.com/agent/guide/heroku-ruby/#sidekiq

## Configure Bugsnag

Use the offical guide to set up Bugsnag, very quick and easy.
https://docs.bugsnag.com/platforms/ruby/rails/#basic-configuration
- Stored BUGSNAG_API_KEY in the Rails credentials file
- Added RAILS_MASTER_KEY to Heroku to give access to Rails credentials file in production
- https://medium.com/craft-academy/encrypted-credentials-in-ruby-on-rails-9db1f36d8570


## Web scraping

#### Rundown of tools
- [Httparty](https://github.com/jnunemaker/httparty) makes simple HTTP requests. Does not load JS or interact with JS elements on webpages.
- [Selenium](https://www.selenium.dev/) Can interact with JavaScript-rendered pages and supports user interactions (clicks, form submissions, scrolling). Requires careful setup to avoid concurrency issues.
- [Ferrum](https://github.com/rubycdp/ferrum)  Headless Chrome-based scraping without Selenium dependencies , Faster than Selenium (doesn't require a WebDriver), Lightweight and Ruby-native, Supports JavaScript execution and DOM interactions & no concurrency issues by default
- [Loofah](https://github.com/flavorjones/loofah) gem is a **sanitization and HTML/XML manipulation library** for Ruby, built on **Nokogiri**, primarily used for **scrubbing and cleaning untrusted HTML** to prevent security vulnerabilities like XSS. I cleans up HTML, removes whitespaces, classes, styles and links.


#### Selenium VS Ferrum explained 
When using Selenium with Chrome, each browser instance typically starts with a user data directory that holds profile data (like cookies, cache, extensions, etc.). When you run multiple instances concurrently—say, in parallel Sidekiq jobs—if they share the same user data directory, you can run into conflicts such as:

-   **Locking Issues:** Chrome might lock the profile directory for one instance, preventing another instance from accessing it.
-   **State Contamination:** Instances might interfere with each other by sharing cookies or cache data, leading to inconsistent behavior.
-   **Startup Failures:** As you've experienced, errors like `"session not created: probably user data directory is already in use..."` occur because multiple processes are trying to access or lock the same resource simultaneously.

### Why Ferrum is better

**Ferrum** (and by extension, **Capybara::Cuprite**) takes a different approach. Instead of launching a full browser instance that relies on a persistent user profile on disk, Ferrum communicates with a headless Chrome instance through the Chrome DevTools Protocol (CDP). Here’s why that can be advantageous in concurrent environments:

1.  **Ephemeral Sessions:**  
    Ferrum typically launches Chrome in a way that creates an ephemeral, in-memory session. This means that each job can start a fresh browser context without worrying about overlapping or reusing disk-based profiles.
    
2.  **No Need for Unique Directories:**  
    Since it isn’t writing or reading from a fixed user data directory, you don’t need to manually create a unique temporary directory for each concurrent job. Each instance is isolated by design, avoiding conflicts.
    
3.  **Simpler Resource Management:**  
    Without the need to manage filesystem-based profiles, you reduce the overhead of cleaning up temporary directories or ensuring they’re uniquely named. This makes scaling up your parallel scraping jobs much simpler.
    
4.  **Faster Startup and Teardown:**  
    The lack of persistent disk state can lead to quicker startup times because there’s no overhead of loading a user profile from disk. When the job completes, the browser session can be terminated without worrying about cleaning up on-disk data.


## TODO
- Link to gist of Selenium Broadwick rb
- Add section here on `session not created: probably user data directory is already in use`
- Add link to https://railsnotes.xyz/blog/ferrum-stealth-browsing
- Include note on having to add sandbox option to get Ferrum to run in production.

?
Selenium::WebDriver 
session not created: probably user data directory is already in use, please specify a unique value for --user-data-dir argument, or don't use --user-data-dir"


????
Do I need this in production? test and remove...
- - heroku config:set REDIS_PROVIDER=REDISCLOUD_URL
????


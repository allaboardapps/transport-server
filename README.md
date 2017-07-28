# Transport Server

## Documentation

* We use [YARD](http://yardoc.org) for documentation
* To update docs, run `yard doc`
* To view docs locally, run `yard server` and visit http://localhost:8808

## Heroku Versions

### Staging

* ruby 2.4.1
* rails 5.1.2
* postgres 9.6.2

### Production

* ruby 2.4.1
* rails 5.1.2
* postgres 9.6.2

## Installation

`rails new transport-server --database=postgresql --skip-spring --skip-turbolinks --skip-test --skip-action-cable`

## Heroku Setup

* Deploys from Github master branch
* `git remote add staging https://git.heroku.com/transport-server-staging.git`
* `git remote add production https://git.heroku.com/transport-server-production.git`

## Security Checks

* run `bundle outdated` > update gems with `bundle update` > run tests
* run `bundle-audit update`
* run `bundle-audit`
* run `brakeman`
* run `hakiri system:steps`
* run `hakiri manifest:generate` > `hakiri system:scan`
* run `hakiri gemfile:scan`

## Security References

* [How Do Ruby/Rails Developers Keep Updated on Security Alerts?](http://gavinmiller.io/2015/staying-up-to-date-with-security-alerts/)
* [Ruby Security Mailing List](https://groups.google.com/forum/#!forum/ruby-security-ann)
* [Rails Security Mailing List](https://groups.google.com/forum/?fromgroups#!forum/rubyonrails-security)
* [CVE Details](https://www.cvedetails.com/)
* [Hakiri service (fee-based)](https://hakiri.io/)
* [AppCanary service (fee-based)](https://appcanary.com/)

### Setup Heroku

First, you'll need to ask to be added as a collaborator to the Heroku projects for access.

Second, you'll need to connect your local git repo to the heroku repos:
* connect to staging: `git remote add staging https://git.heroku.com/happenings-server-staging.git`
* connect to production: `git remote add production https://git.heroku.com/happenings-server-production.git`
* review your remotes: `git remote -v`

You should see something like this:
```
origin  https://github.com/allaboardapps/happenings-server-server.git (fetch)
origin  https://github.com/allaboardapps/happenings-server-server.git (push)
production  https://git.heroku.com/happenings-server-production.git (fetch)
production  https://git.heroku.com/happenings-server-production.git (push)
staging https://git.heroku.com/happenings-server-staging.git (fetch)
staging https://git.heroku.com/happenings-server-staging.git (push)
```
### Setup RVM

* Ref: https://gist.github.com/wrburgess/a6fc079cee6f14fc601b1
* Install with curl: `\curl -sSL https://get.rvm.io | bash -s stable`
* Source RVM: `source /Users/[user]/.rvm/scripts/rvm`
* As a routine process, you may want to update with: `rvm get stable`

### Setup Ruby

* Ref: https://gist.github.com/wrburgess/a6fc079cee6f14fc601b
* Update ruby: `rvm get stable --ruby`
* Confirm ruby version changed: `ruby -v`
* Create `.ruby-version` file in root dir with ruby version number, ex: `2.4.1`

### Setup Environment Variables

* Ref: https://github.com/laserlemon/figaro
* Note: We use the figaro gem to store and access env variables out of the reach of source control
* Note: You will need to retrieve the valid variables from a team member and place the contents in the `/config/application.yml` file.

### Setup Foreman

* Ref: https://github.com/ddollar/foreman
* Install: `gem install foreman`
* Note: This will run the `Procfile` and `Procfile.development` instructions
* Note: You can run your processes with `foreman start -f Procfile.development`
* Note: Heroku will utilize the `Procfile` instructions

### Run Servers

* to run the local server type `rails server` or `rails s`
* visit `localhost:3000`

### Quality Control

* run Rails tests: `bundle exec rspec spec`
* run Rubocop linting: `rubocop`

### Email Management

#### Development

* We are using [Letter Opener Web](https://github.com/fgrehm/letter_opener_web) which will ease the development of emails.
* Instead of actually sending the emails, are caught and stored at `/tmp/letter_opener`.
* You can view and delete the emails at `http://localhost:3000/letter_opener/`

#### Staging

We are using Mailtrap

#### Production

We are using Postmark

### Deployment

1. Push your branch to GitHub with `git push origin [branch-name]`
1. Our CI System will build the app, run `rspec`, and scan style with `rubocop`.
1. When the `master` branch passes on the CI build, the app will be deployed to the staging server on Heroku
1. The application is hosted on a Heroku Pipeline named [transport-server](https://dashboard.heroku.com/pipelines/dd583b0f-4721-4cf5-b195-b29f5bee8092)
1. You can promote the staging app to production (`transport-server-staging` to `transport-server-production`) via `heroku pipelines:promote -r staging`
1. The deploy tasks are located in the `/lib/tasks/app.rake` file
1. To create a new version tag the last commit with `git tag -d v[semver]` and `git push --tags origin`

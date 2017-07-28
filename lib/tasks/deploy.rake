namespace :deploy do
  desc "Post-deployment processes for review apps"
  task :review_app, [:app_name] => :environment do |t, args|
    commands = [
      %{ git remote set-url review https://git.heroku.com/#{args[:app_name]}.git },
      %{ heroku config:set REDIS_URL=`heroku config:get REDISTOGO_URL -a #{args[:app_name]}` -r review },
      %{ heroku config:set REDIS_PROVIDER=`heroku config:get REDISTOGO_URL -a #{args[:app_name]}` -r review }
    ]

    exec commands.join(" && ")
  end
end

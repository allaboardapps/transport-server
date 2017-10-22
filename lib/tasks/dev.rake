namespace :dev do
  desc "Reload the databases: drop, create, migrate"
  task :rebuild do
    STDOUT.puts "Drop and recreate all databases? y[es] or n[o]"
    input = STDIN.gets.chomp
    if input == "y"
      puts "Executing tasks..."
      system "bundle exec rake db:drop db:create db:migrate"
      puts "Tasks completed"
    else
      puts "Aborting tasks..."
    end
  end
end

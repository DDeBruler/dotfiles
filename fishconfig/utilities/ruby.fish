function rdm -w "rake db:migrate" 
  if test -e Gemfile -a -d db
    migrate_databases
  else
    echo "No rails database configuration found"
  end
end

function migrate_databases
  echo "Migrating development database"
  bundle exec rake db:migrate
  echo -e "\nMigrating test database"
  env RAILS_ENV=test bundle exec rake db:migrate
end


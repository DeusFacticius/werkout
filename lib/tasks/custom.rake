namespace :custom do
  desc "Reset database and reload fixture data"
  task dbreset: [:environment, 'db:reset', 'db:fixtures:load']

end

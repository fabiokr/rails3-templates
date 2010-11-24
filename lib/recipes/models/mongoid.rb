gem 'mongoid', '2.0.0.beta.20'
gem 'bson_ext', '>= 1.1.2'

after_gems << lambda do
  generate 'mongoid:config'
  comment 'config/application.rb', "require 'active_record/railtie'"
  repo_commit 'Installed Mongoid'
end

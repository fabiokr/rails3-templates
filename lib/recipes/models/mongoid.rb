gem 'mongoid', '2.0.0.beta.20'
gem 'bson_ext', '>= 1.1.2'
gem 'remarkable_mongoid', :group => [:development, :test]

after_gems << lambda do
  generate 'mongoid:config'
  comment 'config/application.rb', "require 'active_record/railtie'"
  comment 'Gemfile', "gem 'sqlite3-ruby'"
  comment 'Gemfile', 'gem "remarkable_activerecord"'

  inject_into_file "spec/spec_helper.rb", "require 'remarkable/mongoid'\n", :after => "require 'remarkable/active_record'\n"

  inject_into_file "spec/spec_helper.rb", "config.before :each do\nMongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)\nend\n", :after => "#config.use_transactional_fixtures = true\n"

  comment 'spec/spec_helper.rb', "require 'remarkable/active_record'"
  comment 'spec/spec_helper.rb', 'config.use_transactional_fixtures'

  repo_commit 'Added Mongoid'
end

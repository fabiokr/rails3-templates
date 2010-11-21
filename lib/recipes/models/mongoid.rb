if(yes?('Install Mongoid?'))
  set_option :mongoid, true
  gem 'mongoid', '2.0.0.beta.20'
  gem 'bson_ext', '>= 1.1.2'

  after_gems(lambda do
    generate 'mongoid:config'
    comment 'config/application.rb', "require 'active_record/railtie'"
  end)
end

gem 'rspec-rails', '~> 2.0.1', :group => [:development, :test]
gem 'steak', :group => [:development, :test]
gem 'capybara', :group => [:development, :test]
gem 'spork', '~> 0.9.0.rc2', :group => [:test]
gem 'factory_girl_rails', :group => [:test]
gem 'guard-rspec', :group => [:test]
gem 'guard-spork', :group => [:test]
gem 'libnotify', :group => [:test]
gem 'rb-inotify', :group => [:test]
gem 'metric_fu', :group => [:test]
gem 'cover_me', :group => [:test]

#Remarkable matchers
gem 'remarkable', '~> 4.0.0.alpha2', :group => [:test]
gem 'remarkable_activemodel', '~> 4.0.0.alpha4', :group => [:test]
gem 'remarkable_activerecord', '~> 4.0.0.alpha2', :group => [:test]

after_gems << lambda do
  generate 'rspec:install'
  generate 'steak:install'
  run 'spork --bootstrap'

  remove_file 'test'
  remove_file 'autotest'

  spec_helper_requires = %w(remarkable/active_model remarkable/active_record factory_girl cover_me).map {|requirement| "require '#{requirement}'"}.join("\n")
  inject_into_file "spec/spec_helper.rb", spec_helper_requires + "\n", :after => "require 'rspec/rails'\n"
  inject_into_file "spec/spec_helper.rb", "\n  ActiveSupport::Dependencies.clear\n", :after => "config.use_transactional_fixtures = true\n"
  inject_into_file "config/application.rb", "\n" + template_content('rspec/config/application.rb.spork'), :after => "config.filter_parameters += [:password]\n"

  comment 'spec/spec_helper.rb', 'config.fixture_path'

  create_file 'spec/factories/.gitkeep', ""
  create_file 'Guardfile', template_content('rspec/Guardfile')
  create_file 'lib/tasks/metrics.rake', template_content('rspec/lib/tasks/metrics.rake')

  append_file '.gitignore', "coverage.data\n"
  append_file '.rspec', "--drb\n"

  repo_commit 'Added Rspec'
end

gem 'rspec-rails', '~> 2.0.1', :group => [:development, :test]
gem 'spork', '>= 0.9.0.rc2', :group => [:development, :test]
gem 'autotest-rails', :group => [:development, :test]
gem 'autotest-notification', :group => [:development, :test]
gem 'steak', '>= 1.0.0.rc.1', :group => [:development, :test]
gem 'capybara', :group => [:development, :test]
gem 'launchy', :group => [:development, :test]
gem 'factory_girl_rails', :group => [:development, :test]

#Remarkable matchers
gem 'remarkable', '>=4.0.0.alpha2', :group => [:test]
gem 'remarkable_activemodel', '>=4.0.0.alpha4', :group => [:test]
gem 'remarkable_activerecord', '>=4.0.0.alpha2', :group => [:test]

after_gems << lambda do
  remove_file 'test'
  generate 'rspec:install'
  generate 'steak:install'
  run 'spork --bootstrap'

  append_file '.rspec', '--drb'

  spec_helper_requires = %w(remarkable/active_model remarkable/active_record factory_girl ).map {|requirement| "require '#{requirement}'"}.join("\n")
  inject_into_file "spec/spec_helper.rb", spec_helper_requires, :after => "require 'rspec/rails'\n"

  comment 'spec/spec_helper.rb', 'config.fixture_path'

  repo_commit 'Added Rspec'
end

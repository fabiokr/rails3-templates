gem 'rspec-rails', '~> 2.0.1', :group => [:development, :test]
gem 'steak', :group => [:development, :test]
gem 'capybara', :group => [:development, :test]
gem 'factory_girl_rails', :group => [:test]
gem 'guard-rspec', :group => [:test]
gem 'libnotify', :group => [:test]
gem 'rb-inotify', :group => [:test]

#Remarkable matchers
gem 'remarkable', '~> 4.0.0.alpha2', :group => [:test]
gem 'remarkable_activemodel', '~> 4.0.0.alpha4', :group => [:test]
gem 'remarkable_activerecord', '~> 4.0.0.alpha2', :group => [:test]

after_gems << lambda do
  generate 'rspec:install'
  generate 'steak:install'

  remove_file 'test'
  remove_file 'autotest'

  spec_helper_requires = %w(remarkable/active_model remarkable/active_record factory_girl).map {|requirement| "require '#{requirement}'"}.join("\n")
  inject_into_file "spec/spec_helper.rb", spec_helper_requires + "\n", :after => "require 'rspec/rails'\n"

  comment 'spec/spec_helper.rb', 'config.fixture_path'

  create_file 'spec/factories/.gitkeep', ""
  create_file 'Guardfile', template_content('rspec/Guardfile')

  repo_commit 'Added Rspec'
end

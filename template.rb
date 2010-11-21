require File.join(File.dirname(__FILE__), 'lib', 'core_extensions.rb')

apply recipe('default')
apply recipe('mongoid', 'models')

run 'bundle install'
execute_after_gems

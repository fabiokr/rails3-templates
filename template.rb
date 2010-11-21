require File.join(File.dirname(__FILE__), 'lib/core_extensions.rb')

repo_init
repo_commit 'Rails app created'

# Files to be removed
[ 'README', 
  'public/index.html', 
  'public/robots.txt', 
  'public/images/rails.png'
].each do |file|
  remove_file file
end

# Files to be created
[ 'README' ].each do |file|
  create_file file
end

# Changes Rails Railties require statement, so that we can easily replace Railties later
railties = %w(active_record action_controller action_mailer active_resource).map {|railtie| "require '#{railtie}/railtie'"}.join("\n")
gsub_file 'config/application.rb', /require 'rails\/all'/, railties

# Additions to .gitignore
append_file '.gitignore', '*.swp'

repo_commit 'Initial file changes'

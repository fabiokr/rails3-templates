gem 'haml-rails'

after_gems << lambda do
  remove_file 'app/views/layouts/application.html.erb'
  create_file 'app/views/layouts/application.html.haml', template_content('haml/app/views/layouts/application.html.haml')
  generate 'controller welcome index'
  gsub_file 'config/routes.rb', '# root :to => "welcome#index"', 'root :to => "welcome#index"'
  repo_commit 'Added Haml'
end

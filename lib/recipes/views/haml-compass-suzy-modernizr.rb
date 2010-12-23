gem 'haml-rails'
gem 'compass-susy-plugin'

after_gems << lambda do
  #Susy
  run 'compass init rails . -r susy --using susy -x sass --force'
  remove_file 'app/stylesheets/screen.scss'
  create_file 'app/stylesheets/screen.scss', template_content('haml-compass-suzy-modernizr/app/stylesheets/screen.scss')
  append_file '.gitignore', "\npublic/stylesheets/compiled"
  repo_commit 'Added Suzy'

  #Modernizr
  get "https://github.com/Modernizr/Modernizr/raw/master/modernizr.js", "public/javascripts/lib/modernizr.js"
  repo_commit 'Added Modernizr'

  #Haml template
  remove_file 'app/views/layouts/application.html.erb'
  create_file 'app/views/layouts/application.html.haml', template_content('haml-compass-suzy-modernizr/app/views/layouts/application.html.haml')
  create_file 'app/views/layouts/_flash.html.haml', template_content('haml-compass-suzy-modernizr/app/views/layouts/_flash.html.haml')
  repo_commit 'Added Haml layout'
end

require File.join(File.dirname(__FILE__), 'lib', 'core_extensions.rb')

initialize_parameters

apply recipe_path('default')
apply recipe_path('rails3_generators', 'general')
apply recipe_path('haml-compass-suzy-modernizr', 'views')

optional_recipes = {:models => [:mongoid]}

optional_recipes.each do |group, group_recipes|
  group_recipes.each do |recipe|
    if(recipe?(recipe))
      apply recipe_path(recipe, group)
    end
  end
end

run 'bundle install'
repo_commit 'Bundle install'

execute_after_gems

#Generates sample controller
generate 'controller welcome index'
gsub_file 'config/routes.rb', '# root :to => "welcome#index"', 'root :to => "welcome#index"'
repo_commit 'Added Welcome controller'

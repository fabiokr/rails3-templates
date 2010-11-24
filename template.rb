require File.join(File.dirname(__FILE__), 'lib', 'core_extensions.rb')

initialize_parameters

recipes = {:models => [:mongoid]}

apply recipe_path('default')

recipes.each do |group, group_recipes|
  group_recipes.each do |recipe|
    if(recipe?(recipe))
      apply recipe_path(recipe, group)
    end
  end
end

run 'bundle install'
repo_commit 'Bundle install'

execute_after_gems

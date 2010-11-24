module Rails
  module Generators
    module Actions

      attr_accessor :after_gems, :template_options 

      # Adds a # before the found content
      def comment(path, content)
        gsub_file path, content, "##{content}"
      end

      # Executes all procs 
      def execute_after_gems
        @after_gems.each {|proc| proc.call } 
      end      

      # Initializes the parameters
      def initialize_parameters
        @after_gems = []
        @template_options = {}
      end

      # Asks if a recipe should be applied and stores the recipe option
      def recipe?(recipe)
        template_options[recipe.to_sym] = yes?(("Install #{recipe.to_s}?"))
      end

      # Retrieves the file path to a given recipe
      def recipe_path(recipe, group = '')
        File.join File.dirname(__FILE__), 'recipes', group.to_s, "#{recipe.to_s}.rb" 
      end

      # Commit all current changes on version control
      def repo_commit(msg)
        git :add => '-u'
        git :add => '.'
        git :commit => "-m \"#{msg}\""             
      end

      # Initializer the version control repository
      def repo_init
        git :init
      end

    end
  end
end

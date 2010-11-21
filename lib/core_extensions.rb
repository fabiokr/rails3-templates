module Rails
  module Generators
    module Actions
      
      def repo_init
        git :init
      end

      def repo_commit(msg)
        git :add => '-u'
        git :add => '.'
        git :commit => "-m \"#{msg}\""             
      end

      def recipe(recipe, group = '')
        File.join File.dirname(__FILE__), 'recipes', group, "#{recipe}.rb" 
      end

    end
  end
end

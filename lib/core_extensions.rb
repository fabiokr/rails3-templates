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

    end
  end
end

module Rails
  module Generators
    module Actions
    
      def set_option(option, value)
        @template_options = {} if @template_options.nil?
        @template_options[option.to_sym] = value
      end

      # Delays a generator proc to be executed after gems installation
      def after_gems(proc)
        @after_gems = [] if @after_gems.nil?
        @after_gems << proc
      end

      # Executes all procs 
      def execute_after_gems
        @after_gems.each {|proc| proc.call } 
      end

      # Initializer the version control repository
      def repo_init
        git :init
      end

      # Commit all current changes on version control
      def repo_commit(msg)
        git :add => '-u'
        git :add => '.'
        git :commit => "-m \"#{msg}\""             
      end

      # Retrieves the file path to a given recipe
      def recipe(recipe, group = '')
        File.join File.dirname(__FILE__), 'recipes', group, "#{recipe}.rb" 
      end

      # Adds a # before the found content
      def comment(path, content)
        gsub_file path, content, "##{content}"
      end

    end
  end
end

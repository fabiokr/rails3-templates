require 'metric_fu'
require 'cover_me'

MetricFu::Configuration.run do |config|
  #:saikuro does not work on ruby 1.9.2
  #:rcov - instead of rcov we're using cover_me
  config.metrics  = [:churn, :flog, :flay, :reek, :roodi, :hotspots, :stats, :rails_best_practices]
end

CoverMe.config do |c|
  c.html_formatter.output_path = File.join(CoverMe.config.project.root, 'tmp', 'cover_me')
end

task :report do
  Rake::Task['spec'].invoke
  Rake::Task['metrics:all'].invoke
  CoverMe.complete!
end

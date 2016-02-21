task :default => :run

require_relative './lib/pm'
task :run, [:file] do |t, args|
  args.with_defaults(:file => './data')
  PM::Finder.work! "#{args[:file]}"
end

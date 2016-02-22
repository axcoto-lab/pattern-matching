task :default, [:file] do |t, args|
  args.with_defaults(:file => 'data')
  Rake::Task[:run].invoke(args[:file])
end

require_relative './lib/pm'
task :run, [:file] do |t, args|
  PM::Finder.work! "#{args[:file]}"
end

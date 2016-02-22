require_relative './lib/pm'

task :default, [:file, :threshold] do |t, args|
  args.with_defaults({:file => 'data/small.txt'})
  Rake::Task[:run].invoke args
end

task :run, [:file, :threshold] do |t, args|
  PM::Finder.work! args
end

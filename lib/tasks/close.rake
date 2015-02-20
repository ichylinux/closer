require 'rake'

dependencies = ['environment', 'db:test:prepare']
unless defined?(Rails)
  dependencies.each do |t|
    task t do; end
  end
end

task :close => dependencies do |t, args|
  options = [
    'DRIVER=' + (ENV['DRIVER'] || 'poltergeist'),
    'PAUSE=' + (ENV['PAUSE'] || '0'),
    'COVERAGE=' + (ENV['COVERAGE'] || 'false'),
    'ACCEPTANCE_TEST=true',
    'EXPAND=' + (ENV['EXPAND'] || 'true')
  ].join(' ')
  
  features = []
  ARGV[1..-1].each do |arg|
    unless arg.index('=')
      task arg.to_sym do ; end
      features << arg.gsub(/:/, '\:')
    end
  end

  feature_dir =  'features'
  if features.first
    dir = File.dirname(features.first)
    feature_dir = dir == '.' ? File.basename(features.first) : dir
  end
  puts "using features in #{feature_dir}"

  format = ENV['FORMAT'] || 'Closer::Formatter::Html'
  unless format.empty?
    case format
    when 'junit'
      output = File.join('test', 'reports')
      FileUtils.mkdir_p(output)
    else
      output = File.join(feature_dir, 'reports', 'index.html')
      FileUtils.mkdir_p(File.dirname(output))
    end
    additional_format = "--format #{format} --out #{output}"
  end

  args = [
    "-r #{feature_dir}",
    feature_dir == 'features' ? '' : '--exclude features/step_definitions',
    '--guess',
    '--quiet',
    '--no-multiline',
    '--format pretty',
    additional_format,
    features.join(' ')
  ].join(' ')

  fail unless system("bundle exec cucumber #{args} #{options}")
end

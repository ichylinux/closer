require 'rake'

dependencies = ['environment', 'db:test:prepare']
unless defined?(Rails)
  dependencies.each do |t|
    task t do; end
  end
end

task :close => dependencies do |t, args|
  features = []
  ARGV[1..-1].each do |arg|
    unless arg.index('=')
      task arg.to_sym do ; end
      features << arg.gsub(/:/, '\:')
    end
  end

  feature_dir = 'features'
  if features.first
    dir = features.first
    while dir != '.'
      feature_dir = dir
      dir = File.dirname(dir)
    end
  end
  puts "using features in directory #{feature_dir}" unless feature_dir == 'features'

  format = ENV['FORMAT'] || 'Closer::Formatter::Html'
  unless format.empty?
    case format
    when 'junit'
      output = File.join(feature_dir, 'reports')
      FileUtils.mkdir_p(output)
    else
      output = File.join(feature_dir, 'reports', 'index.html')
      FileUtils.mkdir_p(File.dirname(output))
    end
    additional_format = "--format #{format} --out #{output}"
  end

  args = [
    "--require #{feature_dir}",
    '--guess',
    '--quiet',
    '--no-multiline',
    '--format pretty',
    additional_format,
    features.join(' ')
  ].join(' ')

  options = [
    'DRIVER=' + (ENV['DRIVER'] || 'poltergeist'),
    'PAUSE=' + (ENV['PAUSE'] || '0'),
    'COVERAGE=' + (ENV['COVERAGE'] || 'false'),
    'ACCEPTANCE_TEST=true',
    'EXPAND=' + (ENV['EXPAND'] || 'true'),
    'COMMAND_NAME=' + (ENV['COMMAND_NAME'] || feature_dir.split('_').map{|a| a.capitalize }.join)
  ].join(' ')

  report_dir = File.join(feature_dir, 'reports')
  fail unless system("mkdir -p #{report_dir}")
  fail unless system("rm -Rf #{report_dir}/*")
  fail unless system("bundle exec cucumber #{args} #{options}")
end

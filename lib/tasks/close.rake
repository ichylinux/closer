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
    next if arg.start_with?('-') or arg.index('=')

    task arg.to_sym do ; end
    features << arg.gsub(/:/, '\:')
  end

  feature_dir = 'features'
  if features.first
    dir = features.first
    while dir != '.'
      feature_dir = dir
      dir = File.dirname(dir)
    end
    feature_dir = File.basename(feature_dir)
  end
  puts "using features in directory #{feature_dir}" unless feature_dir == 'features'

  format = ENV['FORMAT'] || 'html'
  unless format.empty?
    case format
    when 'junit'
      output = File.join(feature_dir, 'reports')
      FileUtils.mkdir_p(output)
    else
      output = File.join(feature_dir, 'reports', 'index.html')
      FileUtils.mkdir_p(File.dirname(output))
    end
    format_arg = "--format pretty --format #{format} --out #{output}"
  end

  args = [
    "--require #{feature_dir}",
    '--guess',
    '--no-multiline',
    format_arg
  ]
  args << '--dry-run' if ENV['DRY_RUN'] or ENV['DR']

  if ENV['RETRY'].to_i > 0
    args << "--retry #{ENV['RETRY'].to_i}"
    args << '--no-strict'
  end

  options = [
    'DRIVER=' + (ENV['DRIVER'] || 'headless_chrome'),
    'PAUSE=' + (ENV['PAUSE'] || '0'),
    'COVERAGE=' + (ENV['COVERAGE'] || 'false'),
    'ACCEPTANCE_TEST=true',
    'EXPAND=' + (ENV['EXPAND'] || 'true'),
    'COMMAND_NAME=' + (ENV['COMMAND_NAME'] || feature_dir.split('_').map{|a| a.capitalize }.join)
  ]

  if feature_dir == 'user_stories'
    options << 'USER_STORY=' + 'true'
    options << 'RESUME_STORY_FROM=' + features.first
    features = ['user_stories']
  else
    args << '--order random' unless ENV['SORT']
  end

  report_dir = File.join(feature_dir, 'reports')
  fail unless system("mkdir -p #{report_dir}")
  fail unless system("rm -Rf #{report_dir}/*")

  command = "bundle exec cucumber #{args.join(' ')} #{options.join(' ')} #{features.join(' ')}"
  puts
  puts command
  puts
  fail unless system(command)
end

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
    'COVERAGE=' + (ENV['COVERAGE'] || 'true'),
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

  format = ENV['FORMAT'] || 'Closer::Formatter::Html'
  if format.to_s.length > 0
    case format
    when 'junit'
      output = "test/reports"
      FileUtils.mkdir_p(output)
    else
      output = "features/reports/index.html"
      FileUtils.mkdir_p(File.dirname(output))
    end
    additional_format = "--format #{format} --out #{output}"
  end

  fail unless system("bundle exec cucumber --guess --quiet --no-multiline -r features --format pretty #{additional_format} #{features.join(' ')} #{options}")
end

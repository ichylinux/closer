Dir::glob(File.join(File.dirname(__FILE__), 'helpers', '*.rb')).each do |file|
  require file
end

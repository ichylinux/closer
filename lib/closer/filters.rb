Dir::glob(File.join(File.dirname(__FILE__), 'filters', '*.rb')).each do |file|
  require file
end

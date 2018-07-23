Dir::glob(File.join(File.dirname(__FILE__), 'cucumber_ext', '**/*.rb')).each do |file|
  require file
end

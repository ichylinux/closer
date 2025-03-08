begin
  require 'multi_test'
  MultiTest.disable_autorun
  puts '[closer] MultiTest.disable_autorun enabled.'
rescue LoadError => e
end

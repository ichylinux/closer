if defined?(Minitest)
  module MinitestWorld
    include Minitest::Assertions
    attr_accessor :assertions
  
    def initialize
      self.assertions = 0
    end
  end
  
  World(MinitestWorld)
end

class Closer::Config
  attr_accessor :merge_timeout

  def merge_timeout
    @merge_timeout || 3600
  end
end
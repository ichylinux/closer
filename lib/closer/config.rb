class Closer::Config

  def coverage_enabled?
    coverage_enabled = true_value?(ENV['COVERAGE']) && true_value?(ENV['ACCEPTANCE_TEST'])
  end

  def merge_timeout
    ENV['MERGE_TIMEOUT'] || 3600
  end

  def remote?
    true_value?(ENV['REMOTE'])
  end

  def headless?
    true_value?(ENV['HEADLESS'])
  end

  private

  def true_value?(value)
    true_values = %w{ true t yes y 1 }
    true_values.include?(value.to_s.downcase)
  end

end

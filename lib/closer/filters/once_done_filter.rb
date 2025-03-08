require 'cucumber/core/filter'

if Closer.config.resume_story?
  CloserOnceDone = Cucumber::Core::Filter.new do
    def test_case(test_case)
      feature_file_to_resume =  Closer.config.resume_story_from
      unless feature_file_to_resume.empty?
        activated_steps = []
        test_case.test_steps.each do |test_step|
          next if test_step.location.file < feature_file_to_resume
          activated_steps << test_step
        end
        test_case.with_steps(activated_steps).describe_to receiver
      end
    end
  end

  InstallPlugin do |config|
    config.filters << CloserOnceDone.new
  end
end

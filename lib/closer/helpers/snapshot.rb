if ENV['USER_STORY']
  unless ENV['CI']
    require_relative 'snapshots/db_dump'
  
    Before do |scenario|
      db_dump = DbDump.instance
      feature_file = scenario.location.file
      
      if Closer.config.resume_stroy_from == feature_file
        db_dump.current_feature = feature_file
        db_dump.load('tmp/user_stories')
      else
        # 直前のDBをダンプしておく
        if db_dump.current_feature != feature_file
          db_dump.current_feature = feature_file
          db_dump.dump
        end
      end
    end
  end

  After do |scenario|
    Cucumber.wants_to_quit = true if scenario.failed?
  end
end

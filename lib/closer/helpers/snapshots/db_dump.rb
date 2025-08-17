require 'yaml'
require 'singleton'

class DbDump
  include Singleton

  attr_accessor :current_feature

  def load(dir)
    db = Dir.glob(File.join(dump_dir, '*.dump.gz')).first
    db ||= Dir.glob(File.join(dir, '*.dump.gz')).first

    if db
      puts "[closer] loading db dump #{db}."
      raise 'DBロードに失敗しました。' unless load_mysql(db)
    end
  end

  def dump(dir = nil)
    raise 'DBダンプの削除に失敗しました。' unless system("rm -f #{dump_dir(dir)}/*.gz")
    raise 'DBダンプに失敗しました。' unless dump_mysql(dump_dir(dir))
  end

  private

  def dump_dir(dir = nil)
    if dir.to_s.empty?
      dir = File.join('tmp', File.dirname(current_feature), File.basename(current_feature, '.feature'))
    end

    dir
  end

  def dump_mysql(dump_dir)
    config = YAML.load(ERB.new(File.read('config/database.yml'), trim_mode: '-').result)[Rails.env]

    host = config['host'] || 'localhost'
    database = config['database']
    user = config['username']
    password = config['password']

    filepath = File.join(dump_dir, "#{database}-#{Time.now.strftime('%Y-%m-%d_%H%M')}.dump.gz")

    FileUtils.mkdir_p(File.dirname(filepath))
    system("mysqldump -u #{user} -p#{password} -h #{host} #{database} --no-tablespaces | gzip > #{filepath}")
  end
  
  def load_mysql(dump_file)
    config = YAML.load(ERB.new(File.read('config/database.yml'), trim_mode: '-').result)[Rails.env]

    host = config['host'] || 'localhost'
    database = config['database']
    user = config['username']
    password = config['password']

    if dump_file.end_with?('.gz')
      system("zcat #{dump_file} | mysql -u #{user} -p#{password} -h #{host} #{database}")
    else
      system("mysql -u #{user} -p#{password} -h #{host} #{database} < #{dump_file}")
    end
  end

end
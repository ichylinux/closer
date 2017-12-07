require 'erb'

module Closer
  module Formatter
    module CloserHtml

      def ruby_version_dir
        unless @_ruby_version_dir
          @_ruby_version_dir = RUBY_VERSION.split('.')[0..1].join('.') + '.0'
        end
        @_ruby_version_dir
      end

      def gem_dir
        ::File.join(Gem.dir, 'gems')
      end

      def feature_id
        @feature.file.force_encoding('UTF-8').gsub(/(\/|\.|\\)/, '_')
      end

      def feature_dir(feature, short = false)
        ret = ''
        
        split = feature.file.split(File::SEPARATOR).reject{|dir| dir.empty? }
        split.reverse[1..-2].each_with_index do |dir, i|
          if i == 0
            if short
              ret = dir.split('.').first + '.'
            else
              ret = dir
            end
          else
            ret = dir.split('.').first + '.' + ret
          end
        end

        ret
      end

      def magic_comment?(comment_line)
        comment = comment_line.to_s

        ['language', 'format'].each do |magic|
          return true if /#\s*#{magic}\s*:.*/ =~ comment
        end
        
        false
      end

      def current_time_string
        ::Time.now.instance_eval{ '%s%03d' % [strftime('%Y%m%d%H%M%S'), (usec / 1000.0).round] }
      end

      def display_keyword(keyword)
        if @in_background
          display_keyword = keyword.strip + ' '
        else
          if keyword.strip == '*'
            display_keyword = ''
          else
            display_keyword = keyword.strip + ' '
          end
        end
      end

      def indent_size(text)
        text.to_s[/\A */].size
      end

    end
  end
end
require "redcarpet"
require "date"

module Web
  # A post that is represented by a number which is related a file.
  # The number should be unique, but it is not enforced
  class Post
    attr_reader :title, :number, :dir, :filename, :content

    DATE_FORMAT = "%Y.%m.%d %H:%M"

    def initialize(dir, num)
      @number = num
      @dir = dir
      @content = nil
      @title = nil
      @filename = nil

      load
    end

    def date
      return nil unless @filename

      if ::HAS_GIT
        date = DateTime.parse raw_date
      else
        # without a git repository fall back to file modification time
        # hopefully it's accurate...
        date = File.new(full_path).mtime
      end

      date.strftime DATE_FORMAT
    end

    def render
      markdown = Redcarpet::Markdown.new Redcarpet::Render::HTML,
                                         :autolink => true,
                                         :space_after_headers => true
      markdown.render @content
    end

    def full_path
      File.join @dir, @filename
    end

    def self.list(dir)
      posts = {}
      Dir[File.join dir, "*.md"].sort { |a,b| b <=> a }.each do |f|
        /\d{3,}/.match(f) do
          |m| posts[m.to_s] = File.open(f) { |file| file.gets.strip }
        end
      end
      posts
    end

private
    def raw_date
      raw = /Date:(.*)\n/.match `git log --format=medium #{@filename}`
      raw[1].strip
    end

    def load
      posts = Dir[File.join(@dir, "#{@number}*")]
      if posts.empty?
        @content = "There is no post with number #{@number}."
        @title = "Not found"
      elsif posts.size > 1
        @content = "Ambiguous post number, please clean it up first."
        @title = "Error - ambiguous post number"
      else
        @content = File.read posts.first
        @title = @content.lines.first.strip
        @filename = File.basename posts.first
      end
    end
  end
end
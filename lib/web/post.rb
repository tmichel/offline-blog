require "redcarpet"

module Web
  # A post that is represented by a number which is related a file.
  # The number should be unique, but it is not enforced
  class Post
    attr_reader :title

    def initialize(dir, num)
      @number = num
      @dir = dir
      @content = nil
      @title = nil
      @date = DateTime.now

      load
    end

    def date
      @date.strftime "%Y.%m.%d %H:%M"
    end

    def render
      markdown = Redcarpet::Markdown.new Redcarpet::Render::HTML,
                                         :autolink => true,
                                         :space_after_headers => true
      markdown.render @content
    end

    def self.list(dir)
      posts = {}
      Dir[File.join dir, "*.md"].sort { |a,b| b <=> a }.each do |f|
        /\d{3,}/.match(f) do
          |m| posts[m.to_s] = File.open(f) { |file| file.gets }
        end
      end
      posts
    end

private
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
        @title = @content.lines.first.chomp
        # TODO: get time from git commit if available
        @date = File.new(posts.first).mtime
      end
    end
  end
end
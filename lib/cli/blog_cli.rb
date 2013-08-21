require "rubygems"
require "bundler/setup"
require "thor"
require "cli/post"

module CLI
  class BlogCLI < Thor
    desc "new TITLE", "Creates a new blog post with the specfied title."
    def new(title)
      post = Post.new Dir.pwd, title
      post.create!
    end
  end
end

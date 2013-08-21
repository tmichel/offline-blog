require "rubygems"
require "bundler/setup"
require "thor"
require "cli/post"
require "web/app"

module CLI
  class BlogCLI < Thor
    desc "new TITLE", "Creates a new blog post with the specfied title."
    def new(title)
      post = Post.new Dir.pwd, title
      post.create!
    end

    desc "read [POST]", "Start the webserver and open the browser."
    long_desc <<-EOF
    Start the webserver and open the browser.

    A post can be given in the form of the filename. If given, the specfic post
    will open in the browser.
    EOF
    def read(post = nil)
      m = /\d{3,}/.match(post)
      tail = "/entry/#{m}" if post && m
      Sinatra::Application.run! :port => 4004 do |server|
        system "x-www-browser http://localhost:4004#{tail} &"
      end
    end
  end
end

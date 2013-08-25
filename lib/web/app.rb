require "sinatra"
require "web/post"
require "util/os"

if development?
  require "sinatra/reloader"
  also_reload File.join(File.dirname(__FILE__), "post.rb")
end

set :bind, '127.0.0.1'

get "/" do
  @posts = Web::Post.list Dir.pwd
  erb :home
end

get %r{/entry/(\d{3,})} do |num|
  @post = Web::Post.new Dir.pwd, num
  @title = @post.title

  erb :post
end

# check for git install and existing repo in working dir
HAS_GIT = OS.command? "git" && system("git branch > /dev/null 2>&1")

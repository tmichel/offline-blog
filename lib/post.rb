# encoding: utf-8
require "editor"

# Class to represent posts. A post is basically a text file.
class Post

  # Initializes a new post object.
  #
  # @param  dir String The directory where the post should be saved to.
  # @param  title String The title of the new post.
  def initialize(dir, title)
    @dir = dir
    @title = title
  end

  # Creates a new blog post.
  #
  # It figures out the next number for a post. It creates an empty file. Fills
  # out the title and opens the specified text editor (it defaults to sublime).
  #
  def create
    new_file = "#{next_number}-#{strip_title}.md"
    File.open(File.join(@dir, new_file), 'w') do |file|
      file.write initial_content
    end

    Editor.open new_file
  end

private

  # for hungarian at the moment
  ACCENTUATED_LETTERS = {
    "á" => "a",
    "é" => "e",
    "í" => "i",
    "ó" => "o",
    "ö" => "o",
    "ő" => "o",
    "ú" => "u",
    "ü" => "u",
    "ű" => "u"
  }

  def strip_title
    stripped = ""
    @title.each_char do |ch|
      if ACCENTUATED_LETTERS[ch]
        stripped << ACCENTUATED_LETTERS[ch]
      elsif ch.strip.empty?
        # whitespace
        stripped << "-"
      else
        stripped << ch
      end
    end
    stripped.downcase
  end

  def next_number
    last = Dir[File.join(@dir, "*.md")].reject { |f| /[0-9]+/.match(f).nil? }.sort.last
    if last && (m = /[0-9]+/.match File.basename(last))
      m.to_s.succ
    else
      '001'
    end
  end

  def initial_content
    cont = @title + "\n" + ("=" * @title.length) + "\n\n"
  end
end

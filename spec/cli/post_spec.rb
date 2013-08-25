# encoding: utf-8

require "spec_helper"
require "cli/post"

include CLI

describe Post do
  describe "stripped title" do
    it "should be without any accents" do
      p = Post.new "", "áéíóöőúüű"
      expect(p.send(:strip_title)).to eq("aeiooouuu")
    end

    it "should be lowercase" do
      p = Post.new "", "HelloWorld"
      expect(p.send(:strip_title)).to eq("helloworld")
    end

    it "should replace whitespace with hyphen" do
      p = Post.new "", "Hello World"
      expect(p.send(:strip_title)).to eq("hello-world")
    end
  end

  describe "#next_number" do
    it "should return 002 for 001" do
      Dir.stub(:[]) { ["/full/path/to/001-hello-world.md"] }
      p = Post.new "", "Hello World"
      expect(p.send(:next_number)).to eq("002")
    end

    it "should not consider numbers in path besides the filename" do
      Dir.stub(:[]) { ["/full/path/004/to/001-hello-world.md"] }
      p = Post.new "", "Hello World"
      expect(p.send(:next_number)).to eq("002")
    end
  end
end

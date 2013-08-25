require "spec_helper"
require "web/post"

include Web

describe Post do
  describe "#list" do
    let(:posts) { Post.list fixtures_path }

    it "should list all post files in given directory" do
      expect(posts.keys).to eq(["001"])
      expect(posts.values).to eq(["Test post"])
    end
  end

  context "when successfully loaded" do
    let(:test_post) { "#{fixtures_path}/001-test-post.md" }
    subject(:post) { Post.new fixtures_path, "001" }

    its(:title) { should eq("Test post") }
    its(:filename) { should eq("001-test-post.md") }
    its(:content) { should eq(File.read(test_post)) }
    its(:full_path) { should eq(test_post)}

    describe "#date" do
      it "should be parsed from git log" do
        stub_const "HAS_GIT", true
        log = <<-eos
        commit 44464e70e6cc155b2098b6690870bd83ab56b05d
        Author: Tamas Michelberger <tomi.michel@gmail.com>
        Date:   Sun Aug 25 23:32:23 2013 +0200")
        eos

        post.stub(:raw_date).and_return(log)

        expect(post.date).to eq("2013.08.25 23:32")
      end

      it "should fall back to File#mtime when git is not available" do
        stub_const "HAS_GIT", false

        test_post_mod_date = File.new(test_post).mtime.strftime Post::DATE_FORMAT
        expect(post.date).to eq(test_post_mod_date)
      end
    end

    it "should render title with <h1> tag" do
      expect(post.render).to match(/h1/)
      expect(post.render).to match(post.title)
    end
  end

  context "when file does not exists" do
    subject(:post) { Post.new fixtures_path, "999" }

    its(:title) { should eq("Not found") }
    its(:filename) { should be_nil }
    its(:date) { should be_nil }
  end

  context "when number is ambiguous" do
    subject do
      Dir.stub(:[]).and_return ["001-test-1.md", "001-test-2.md"]
      Post.new fixtures_path, "001"
    end

    its(:title) { should match(/Error/) }
    its(:filename) { should be_nil }
    its(:date) { should be_nil }
  end
end
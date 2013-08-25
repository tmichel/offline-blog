require "spec_helper"
require "util/os"

describe OS do
  describe "#command?" do
    it "should return true for existing command" do
      expect(OS.command?("echo")).to be_true
    end

    it "should return false for non-existing command" do
      expect(OS.command?("non-existing")).to be_false
    end
  end
end

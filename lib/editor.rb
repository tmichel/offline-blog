# Runs the editor, defaults to sublime
class Editor
  def self.open(file)
    exec "sublime #{file}:4 &"
  end
end

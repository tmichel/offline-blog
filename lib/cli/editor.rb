# Runs the editor, defaults to sublime
module CLI
  class Editor
    def self.open(file)
      # TODO: support multiple text editors and config
      if system("which sublime > /dev/null 2>&1")
        exec "sublime #{file}:4 &"
      else
        warn "Sublime Text is not installed."
      end
    end
  end
end

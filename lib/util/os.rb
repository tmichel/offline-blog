module OS
  # checks if a command is available on the host system
  def self.command?(command)
    system("which #{command} > /dev/null 2>&1")
  end
end

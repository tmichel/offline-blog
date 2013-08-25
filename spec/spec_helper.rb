lib = File.expand_path(File.join(File.dirname(__FILE__), "..", "lib"))
$LOAD_PATH.unshift lib


def fixtures_path
  File.join File.dirname(__FILE__), "fixtures"
end
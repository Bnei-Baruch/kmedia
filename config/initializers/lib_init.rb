Dir.glob("./lib/*.{rb}").each { |file| require file }
Dir.glob("./lib/validators/*.{rb}").each { |file| require file }
require 'term/ansicolor'
require 'logger'

class String
  include Term::ANSIColor
end

class Logger::SimpleFormatter

  # from activesupport/lib/active_support/core_ext/logger.rb
  def call(severity, time, progname, msg)
    pid_colored = sprintf('%s#%d', progname, $$).dark.send([:red, :green, :cyan, :magenta, :yellow][$$ % 5])
    severity_colored = sprintf('%5s', severity).bold.send({'DEBUG' => :cyan, 'INFO' => :white, 'WARN' => :yellow, 'ERROR' => :red, 'FATAL' => :red}[severity.to_s] || :magenta)
    sprintf("%s [%s] %s %s\n", time.strftime('%Y-%m-%d %H:%M:%S'), pid_colored, severity_colored, msg)
  end

end

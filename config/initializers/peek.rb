if Rails.env.development?
  Peek.into Peek::Views::Git, :nwo => 'github/gshilin'
  Peek.into Peek::Views::PerformanceBar
  Peek.into Peek::Views::Mysql2
  Peek.into Peek::Views::Dalli
end
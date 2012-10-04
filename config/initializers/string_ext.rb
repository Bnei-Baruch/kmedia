class String
  def to_bool
    return true if self == true || self =~ (/\A(true|t|yes|y|1)\Z/i)
    return false
  end
end
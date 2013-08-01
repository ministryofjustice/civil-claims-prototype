class User < Person
  scope :randomly, -> { order("RANDOM()") }

  def self.at_random
    randomly.first
  end

  def claims
    Claim.where(:owner => self)
  end
end

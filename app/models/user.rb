class User < Person
  def claims
    Claim.where("person_id = ?", id)
  end
end

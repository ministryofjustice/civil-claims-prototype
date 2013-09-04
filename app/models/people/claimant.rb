class Claimant < Person
	validates :full_name, presence: true, length: { minimum: 5 }
	validates_format_of :phone, with: /\A[0-9\(\)\+\- ]*\z/, allow_blank: true
	validates_format_of :mobile, with: /\A[0-9\(\)\+\- ]*\z/, allow_blank: true
	validates_format_of :email, with: /\A.+@.+\z/, allow_blank: true
end
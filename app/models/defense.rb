class Defense < ActiveRecord::Base
  has_and_belongs_to_many :arrears
  belongs_to :owner, :class_name => 'Defendant'
  has_many :monthly_expenses
end

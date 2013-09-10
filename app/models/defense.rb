class Defense < ActiveRecord::Base
  has_and_belongs_to_many :arrears
  belongs_to :owner, :class_name => 'Defendant'
  has_many :monthly_expenses

  accepts_nested_attributes_for :owner
end

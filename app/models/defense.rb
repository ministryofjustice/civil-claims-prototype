class Defense < ActiveRecord::Base
  has_and_belongs_to_many :arrears
  belongs_to :owner, :class_name => 'Defendant'
  has_many :monthly_expenses, :dependent => :destroy

  accepts_nested_attributes_for :owner
  accepts_nested_attributes_for :monthly_expenses, :allow_destroy => true

  def fill_basic_montly_expenses!
  	self.monthly_expenses.create(
      [
        { :name => 'Council tax', :amount => 0 },
        { :name => 'Gas', :amount => 0 },
        { :name => 'Electricity', :amount => 0 },
        { :name => 'Water', :amount => 0 }
      ]
    )
  end

end

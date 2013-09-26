class Defense < ActiveRecord::Base
  has_and_belongs_to_many :arrears
  belongs_to :owner, :class_name => 'Defendant'
  has_many :monthly_expenses, :dependent => :destroy

  accepts_nested_attributes_for :owner
  accepts_nested_attributes_for :monthly_expenses, :allow_destroy => true

  def total_money_in
    income + pension + child_benefit + other_monies_in
  end

  def fill_basic_monthly_expenses!
  	self.monthly_expenses.create(
      [
        { :name => 'Council tax', :amount => nil },
        { :name => 'Gas', :amount => nil },
        { :name => 'Electricity', :amount => nil },
        { :name => 'Water', :amount => nil }
      ]
    )
  end

  def has_money_in?
    ['employed', 'universal_credit'].include? self.present_circumstances
  end

end

class Defense < ActiveRecord::Base
  has_and_belongs_to_many :arrears
  belongs_to :owner, :class_name => 'Defendant'
  has_many :monthly_expenses, :dependent => :destroy

  accepts_nested_attributes_for :owner
  accepts_nested_attributes_for :monthly_expenses, :allow_destroy => true

  # I've had a hard day, alright. migrations are not my friend right now.
  def get_income
    self.income || 0
  end

  def get_pension
    self.pension || 0
  end

  def get_child_benefit
    self.child_benefit || 0
  end

  def get_other_monies_in
    self.other_monies_in || 0
  end

  def total_money_in
    get_income + get_pension + get_child_benefit + get_other_monies_in
  end

  def total_expenses
    self.monthly_expenses.reduce { |sum, e| e + sum }
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

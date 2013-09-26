class MonthlyExpense < ActiveRecord::Base
  belongs_to :defense

  def + (ac)
    ac ||= 0
    am = self.amount || 0
    ac + am
  end

end

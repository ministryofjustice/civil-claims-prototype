require 'spec_helper'

describe Defense do
  before :each do
    @claim = Claim.new
    @d = Defense.new
  end

  it 'the defense can attach arrears' do
    @d.arrears << Arrear.create
    @d.arrears << Arrear.create
    assert @d.save
    assert @d.arrears.size == 2
  end

  it 'the defense has an owner' do
    assert @d.owner = Defendant.create_random
    assert @d.save
  end

  it 'has monthly expenses' do
    e = MonthlyExpense.new
    e.name = 'Council Tax'
    e.amount = 1000.02
    assert e.save

    assert @d.monthly_expenses << e
  end
end
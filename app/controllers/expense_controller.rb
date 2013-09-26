class ExpenseController < ApplicationController
  def new
    render partial: 'expenses/new', format: :js
  end
end

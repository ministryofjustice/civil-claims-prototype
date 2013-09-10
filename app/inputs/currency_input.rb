class CurrencyInput < SimpleForm::Inputs::StringInput
  def input
    "<strong>&pound</strong> #{super}".html_safe
  end
end
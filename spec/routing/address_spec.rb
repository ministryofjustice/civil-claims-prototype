require 'spec_helper'

describe 'routing to address controller' do
  it 'routes address/picker to address#picker' do
    get("/address/picker").should route_to("address#picker")
  end
end
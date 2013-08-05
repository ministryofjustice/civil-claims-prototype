require 'spec_helper'

describe PeopleController do
  it 'toggles editor visibility' do
    person = Person.create_random
    session[:bypass_auth] = true
    session['editors'] = {person.id => false}
    get(:show_editor, {'id' => person.id})
    assert session['editors'][person.id] == true
  end

end
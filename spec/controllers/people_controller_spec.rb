require 'spec_helper'

describe PeopleController do
  it 'toggles editor visibility' do
    person = Person.create_random
    get(:show_editor, {'id' => person.id}, {'editors' => {person.id => false}})
    assert session['editors'][person.id] == true
  end
end
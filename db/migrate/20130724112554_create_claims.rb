class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.timestamps
      t.belongs_to :person
    end
  end
end

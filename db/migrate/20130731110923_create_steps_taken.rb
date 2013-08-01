class CreateStepsTaken < ActiveRecord::Migration
  def change
    create_table :steps_already_taken_answers do |t|
      t.boolean :notice_to_quit
      t.datetime :date_notice_served

      t.boolean :breach_of_lease
      t.boolean :seeking_possession
      t.boolean :other
      t.string :other_recovery_steps_taken

      t.references :claim
      t.timestamps
    end
  end
end

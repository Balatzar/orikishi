class CreateParticipations < ActiveRecord::Migration[5.1]
  def change
    create_table :participations do |t|
      t.string :email
      t.text :comment
      t.references :survey, index: true

      t.timestamps
    end
  end
end

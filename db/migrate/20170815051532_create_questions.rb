class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.references :survey, index: true
      t.string :text
      t.boolean :required
      t.boolean :multiple

      t.timestamps
    end
  end
end

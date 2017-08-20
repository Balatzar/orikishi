class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.references :participation, index: true
      t.references :question, index: true

      t.timestamps
    end
    
    create_table :answers_choices do |t|
      t.references :answer, index: true
      t.references :choice, index: true
    end
  end
end

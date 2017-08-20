class Survey < ApplicationRecord
  has_many :participations
  has_many :questions
  
  def jsonify
    {
      id: self.id,
      name: self.name,
      random: self.random,
      time: self.time,
      questions: self.questions.sort.map do |q|
        {
          text: q.text,
          required: q.required,
          multiple: q.multiple,
          id: q.id,
          choices: q.choices.sort.map do |c|
            {
              text: c.text,
              id: c.id
            }
          end
        }
      end
    }
  end
end

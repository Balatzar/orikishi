class Survey < ApplicationRecord
  has_many :participations
  has_many :questions
  
  def jsonify
    survey = Survey.includes(questions: :choices).find(self.id)
    {
      id: survey.id,
      name: survey.name,
      random: survey.random,
      time: survey.time,
      questions: survey.questions.sort.map do |q|
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

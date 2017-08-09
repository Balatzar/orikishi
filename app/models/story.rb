class Story < ApplicationRecord
  has_many :steps

  before_create :create_slug

  def create_slug
    self.slug = self.name.parameterize
  end

  def jsonify
    {
      name: self.name,
      steps: self.steps.sort.map do |s|
        {
          frames: s.frames.sort.map do |f|
            {
              text: f.text,
              branches: f.branches.sort.map { |b| b.id },
              id: f.id
            }
          end
        }
      end
    }
  end
end

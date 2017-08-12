class Story < ApplicationRecord
  has_many :steps

  before_create :create_slug

  def create_slug
    self.slug = self.name.parameterize
  end

  def self.create_new_story(story_and_first_frame)
    story = Story.create! name: story_and_first_frame[:name]
    step = Step.create! story: story
    frame = Frame.create!({
      text: story_and_first_frame[:text],
      image: story_and_first_frame[:image],
      step: step
    })
    branch = Branch.create!
    branch.frames << frame
    story
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
              id: f.id,
              url: f.image.url(:medium)
            }
          end
        }
      end
    }
  end
end

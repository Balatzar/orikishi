class Frame < ApplicationRecord
  belongs_to :step
  has_and_belongs_to_many :branches

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def add_follow_up(new_frame)
    step = self.step
    steps = step.story.steps.reload.sort
    frame = Frame.create new_frame
    if step == steps.last
      new_step = Step.create story: step.story
      new_step.frames << frame
      self.branches.sort.first.frames << frame
    else
      next_step = steps[steps.index(step) + 1]
      next_step.frames << frame
      branch = Branch.create!
      frame.branches << self.branches.sort.last
      branch.frames << frame
    end
    frame
  end
end

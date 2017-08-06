class Frame < ApplicationRecord
  belongs_to :step
  has_and_belongs_to_many :branches

  def add_follow_up(new_frame)
    step = self.step
    steps = step.story.steps.reload
    frame = Frame.create new_frame
    if step == steps.last
      new_step = Step.create story: step.story
      new_step.frames << frame
      self.branches.first.frames << frame
    else
      next_step = steps[steps.index(step) + 1]
      next_step.frames << frame
      branch = Branch.create!
      # self.branches << branch
      frame.branches << self.branches.last
      branch.frames << frame
    end
    frame
  end
end

class Frame < ApplicationRecord
  belongs_to :step
  has_and_belongs_to_many :branches

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def add_follow_up(new_frame)
    step = self.step
    steps = step.story.steps.reload.sort
    frame = Frame.create new_frame
    next_step = steps[steps.index(step) + 1]
    branch_from = self.branches.reload.sort.last
    frame.branches << branch_from
    if next_step.nil?
      new_step = Step.create story: step.story
      new_step.frames << frame
    else
      if next_step.frames.find { |f| f.branches.include? branch_from }
        branch_to = Branch.create
        frame.branches << branch_to
      end
      frame.step = next_step
    end
    frame.save
    frame
  end
end

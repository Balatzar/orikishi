class ParticipationController < ApplicationController
  def create
    survey_results = params.require(:survey).permit(:email, :comment, answers: [:id, answers: []])
    participation = Participation.create! email: survey_results[:email], comment: survey_results[:comment], survey: Survey.find(params[:survey_id])
    survey_results[:answers].each do |a|
      answer = Answer.create! question_id: a[:id], participation: participation
      answer.choices << Choice.find(a[:answers])
      answer.save
    end
    head :ok
  end
end

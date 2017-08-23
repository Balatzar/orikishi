class PublicController < ApplicationController
  before_action :set_story, only: [:orikishi]

  def index
    @stories = Story.all
  end

  def orikishi
    @orikishi_engine_props = { story: @story.jsonify, add_follow_up_path: "/#{@story.slug}/add_follow_up" }
    survey = Survey.order("RANDOM()").first
    @survey_props = {
      survey: survey.jsonify,
      postUrl: survey_participation_index_path(survey),
      ending: {
        text:
          "Merci d'avoir repondu ! Vous pouvez nous laisser votre mail si vous acceptez que nous vous contactions pour vous demander votre avis pour des fonctionnalités futures :) Vous pouvez vos idées/suggestions/doléances dans le champ suivant",
        email: true,
        freeSpeech: true,
      },
      messages: {
        errorMessage: "Vous devez selectionner une option",
        welcomeMessage:
          "Bonjour ! Nous esperons que le site vous plait et nous vous serions tres reconnaissants de prendre quelques instants pour repondre a 3 questions :)",
        nextMessage: "Suivant",
        endMessage: "Finir",
        endingMessage: "Merci a vous ! Vos reponses ont été enregistrées !",
        closeMessage: "Fermer",
      }
    }
  end

  def add_follow_up
    frame = Frame.find(params[:frame])
    new_frame = frame.add_follow_up params.require(:newFrame).permit(:text, :image)
    res = {
      new_frame: {
        id: new_frame.id,
        text: new_frame.text,
        branches: new_frame.branches.map { |b| b.id },
        url: new_frame.image.url(:medium)
      },
      old_frame_id: frame.id
    }
    render json: res
  end

  private

  def set_story
    @story = Story.find_by(slug: params[:story])
  end
end
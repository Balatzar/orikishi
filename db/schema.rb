# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170901101608) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.bigint "participation_id"
    t.bigint "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participation_id"], name: "index_answers_on_participation_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "answers_choices", force: :cascade do |t|
    t.bigint "answer_id"
    t.bigint "choice_id"
    t.index ["answer_id"], name: "index_answers_choices_on_answer_id"
    t.index ["choice_id"], name: "index_answers_choices_on_choice_id"
  end

  create_table "branches", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "branches_frames", id: false, force: :cascade do |t|
    t.bigint "frame_id"
    t.bigint "branch_id"
    t.index ["branch_id"], name: "index_branches_frames_on_branch_id"
    t.index ["frame_id"], name: "index_branches_frames_on_frame_id"
  end

  create_table "choices", force: :cascade do |t|
    t.string "text"
    t.bigint "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_choices_on_question_id"
  end

  create_table "frames", force: :cascade do |t|
    t.string "text"
    t.bigint "step_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.index ["step_id"], name: "index_frames_on_step_id"
  end

  create_table "participations", force: :cascade do |t|
    t.string "email"
    t.text "comment"
    t.bigint "survey_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_participations_on_survey_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "survey_id"
    t.string "text"
    t.boolean "required"
    t.boolean "multiple"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_questions_on_survey_id"
  end

  create_table "steps", force: :cascade do |t|
    t.bigint "story_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["story_id"], name: "index_steps_on_story_id"
  end

  create_table "stories", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "surveys", force: :cascade do |t|
    t.string "name"
    t.boolean "random"
    t.integer "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active"
  end

end

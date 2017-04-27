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

ActiveRecord::Schema.define(version: 20161128034837) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abet_metrics", force: :cascade do |t|
    t.integer  "offering_id"
    t.string   "abet"
    t.string   "rating"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["offering_id"], name: "index_abet_metrics_on_offering_id", using: :btree
  end

  create_table "abet_outcomes", force: :cascade do |t|
    t.integer  "track_id"
    t.string   "code"
    t.text     "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["track_id"], name: "index_abet_outcomes_on_track_id", using: :btree
  end

  create_table "airs", force: :cascade do |t|
    t.integer  "document_id"
    t.string   "name"
    t.string   "abetOutcome"
    t.string   "assignee1"
    t.string   "assignee2"
    t.string   "assignee3"
    t.string   "assignee4"
    t.string   "meetingName"
    t.datetime "meetingDate"
    t.text     "analysis"
    t.text     "taken"
    t.text     "conclusion"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["document_id"], name: "index_airs_on_document_id", using: :btree
  end

  create_table "approvers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "track_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["track_id"], name: "index_approvers_on_track_id", using: :btree
    t.index ["user_id"], name: "index_approvers_on_user_id", using: :btree
  end

  create_table "authors", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "document_id"
    t.text     "text"
    t.datetime "date"
    t.string   "type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "course_outcomes", force: :cascade do |t|
    t.integer  "offering_id"
    t.text     "outcome"
    t.string   "rating"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["offering_id"], name: "index_course_outcomes_on_offering_id", using: :btree
  end

  create_table "course_track_lists", force: :cascade do |t|
    t.integer  "track_id"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_track_lists_on_course_id", using: :btree
    t.index ["track_id"], name: "index_course_track_lists_on_track_id", using: :btree
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.string   "code_suffix"
    t.string   "code_prefix"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "degrees", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "documents", force: :cascade do |t|
    t.string   "name"
    t.string   "status"
    t.datetime "assigned"
    t.datetime "due"
    t.string   "formType"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "eocms", force: :cascade do |t|
    t.integer  "document_id"
    t.string   "evaluation"
    t.text     "comment_outcomes"
    t.text     "comment_worked"
    t.text     "comment_changes"
    t.text     "comment_rec"
    t.text     "comment_implemented"
    t.text     "comment_results"
    t.text     "comment_additional"
    t.text     "comment_failed"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["document_id"], name: "index_eocms_on_document_id", using: :btree
  end

  create_table "libraries", force: :cascade do |t|
    t.integer  "offering_id"
    t.integer  "document_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["document_id"], name: "index_libraries_on_document_id", using: :btree
    t.index ["offering_id"], name: "index_libraries_on_offering_id", using: :btree
  end

  create_table "master_matrices", force: :cascade do |t|
    t.integer  "track_id"
    t.integer  "course_id"
    t.integer  "abet_outcome_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["abet_outcome_id"], name: "index_master_matrices_on_abet_outcome_id", using: :btree
    t.index ["course_id"], name: "index_master_matrices_on_course_id", using: :btree
    t.index ["track_id"], name: "index_master_matrices_on_track_id", using: :btree
  end

  create_table "offerings", force: :cascade do |t|
    t.string   "CRN"
    t.string   "section"
    t.integer  "year"
    t.string   "term"
    t.string   "evaluation"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_offerings_on_course_id", using: :btree
  end

  create_table "pies", force: :cascade do |t|
    t.integer  "document_id"
    t.text     "name"
    t.string   "abet_outcome"
    t.text     "description"
    t.float    "tpercent"
    t.text     "tscore"
    t.float    "rpercent"
    t.string   "rscore"
    t.text     "calculation"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["document_id"], name: "index_pies_on_document_id", using: :btree
  end

  create_table "resources", force: :cascade do |t|
    t.integer  "document_id"
    t.text     "location"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "teachings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "offering_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["offering_id"], name: "index_teachings_on_offering_id", using: :btree
    t.index ["user_id"], name: "index_teachings_on_user_id", using: :btree
  end

  create_table "tracks", force: :cascade do |t|
    t.integer  "degree_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["degree_id"], name: "index_tracks_on_degree_id", using: :btree
  end

  create_table "uploaders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "file_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password"
    t.string   "fname"
    t.string   "lname"
    t.string   "email"
    t.string   "permission"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

  add_foreign_key "abet_metrics", "offerings"
  add_foreign_key "abet_outcomes", "tracks"
  add_foreign_key "airs", "documents"
  add_foreign_key "approvers", "tracks"
  add_foreign_key "approvers", "users"
  add_foreign_key "course_outcomes", "offerings"
  add_foreign_key "course_track_lists", "courses"
  add_foreign_key "course_track_lists", "tracks"
  add_foreign_key "eocms", "documents"
  add_foreign_key "libraries", "documents"
  add_foreign_key "libraries", "offerings"
  add_foreign_key "master_matrices", "abet_outcomes"
  add_foreign_key "master_matrices", "courses"
  add_foreign_key "master_matrices", "tracks"
  add_foreign_key "offerings", "courses"
  add_foreign_key "pies", "documents"
  add_foreign_key "teachings", "offerings"
  add_foreign_key "teachings", "users"
  add_foreign_key "tracks", "degrees"
end

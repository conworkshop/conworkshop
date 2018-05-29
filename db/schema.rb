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

ActiveRecord::Schema.define(version: 2018_05_29_082547) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clan_memberships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "clan_id"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clan_id"], name: "index_clan_memberships_on_clan_id"
    t.index ["user_id"], name: "index_clan_memberships_on_user_id"
  end

  create_table "clan_requests", force: :cascade do |t|
    t.integer "user_id"
    t.integer "clan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clan_id"], name: "index_clan_requests_on_clan_id"
    t.index ["user_id"], name: "index_clan_requests_on_user_id"
  end

  create_table "clans", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "page_text"
    t.string "colour"
    t.string "symbol"
    t.string "permission"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.boolean "concrete_members", default: true
    t.index ["slug"], name: "index_clans_on_slug"
  end

  create_table "lang_types", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_lang_types_on_code"
  end

  create_table "languages", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "nativename"
    t.string "ipa"
    t.integer "lang_type_id"
    t.string "phonosystem"
    t.string "lexcols"
    t.integer "user_id"
    t.text "overview"
    t.boolean "public"
    t.integer "status", default: 0
    t.boolean "prunesafe"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "flag", comment: "This is here and not in the flag table for easier access to the URL -- it's used everywhere."
    t.index ["code"], name: "index_languages_on_code", unique: true
    t.index ["lang_type_id"], name: "index_languages_on_lang_type_id"
    t.index ["user_id"], name: "index_languages_on_user_id"
  end

  create_table "phones", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "col"
    t.string "row"
    t.string "articulation"
    t.boolean "voiceless"
    t.string "ipa"
    t.string "sampa"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "rounded"
    t.index ["code"], name: "index_phones_on_code", unique: true
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "user_id"
    t.string "gender"
    t.string "country"
    t.text "about"
    t.string "avatar"
    t.string "language"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "user_tracks", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "tracked_at"
    t.string "route"
    t.index ["user_id"], name: "index_user_tracks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uid"
    t.string "username", limit: 24, default: "", null: false
    t.string "pseudonym"
    t.string "timezone"
    t.string "group", default: "R", null: false
    t.integer "flags"
    t.integer "auth_type", default: 1, null: false
    t.string "provider"
    t.string "oaid"
    t.text "preferences", default: "{}"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "default_clan_id"
    t.integer "current_lang_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["default_clan_id"], name: "index_users_on_default_clan_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["oaid"], name: "index_users_on_oaid"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid"], name: "index_users_on_uid", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "wordlinks", force: :cascade do |t|
    t.string "wlid"
    t.string "english"
    t.string "american"
    t.string "class"
    t.string "hint"
    t.text "notes"
    t.text "locale"
    t.bigint "user_id"
    t.boolean "locked"
    t.integer "count"
    t.bigint "last_update_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["last_update_user_id"], name: "index_wordlinks_on_last_update_user_id"
    t.index ["user_id"], name: "index_wordlinks_on_user_id"
    t.index ["wlid"], name: "index_wordlinks_on_wlid", unique: true
  end

  add_foreign_key "users", "languages", column: "current_lang_id", on_delete: :nullify
end

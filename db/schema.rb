# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150511191211) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.integer  "lodestone_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "synced_at"
  end

  add_index "achievements", ["name"], name: "index_achievements_on_name", using: :btree

  create_table "achievements_characters", force: :cascade do |t|
    t.integer  "character_id"
    t.integer  "achievement_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "achievements_characters", ["achievement_id"], name: "index_achievements_characters_on_achievement_id", using: :btree
  add_index "achievements_characters", ["character_id"], name: "index_achievements_characters_on_character_id", using: :btree

  create_table "characters", force: :cascade do |t|
    t.integer  "lodestone_id", limit: 8
    t.string   "first_name"
    t.string   "last_name"
    t.string   "world"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.text     "bio"
    t.integer  "user_id"
    t.datetime "synced_at"
    t.json     "info",                   default: {}, null: false
  end

  add_index "characters", ["user_id"], name: "index_characters_on_user_id", using: :btree

  create_table "characters_groups", force: :cascade do |t|
    t.integer  "character_id"
    t.integer  "group_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "characters_groups", ["character_id"], name: "index_characters_groups_on_character_id", using: :btree
  add_index "characters_groups", ["group_id"], name: "index_characters_groups_on_group_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.integer  "group_id"
    t.string   "name"
    t.time     "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name",       null: false
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_categories", force: :cascade do |t|
    t.string   "lodestone_id"
    t.string   "name"
    t.string   "attr1"
    t.string   "attr2"
    t.string   "attr3"
    t.integer  "parent_id"
    t.datetime "synced_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "item_categories", ["parent_id"], name: "index_item_categories_on_parent_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "lodestone_id"
    t.string   "name"
    t.text     "description"
    t.integer  "ilvl"
    t.string   "classes"
    t.integer  "level"
    t.decimal  "attr1"
    t.decimal  "attr2"
    t.decimal  "attr3"
    t.json     "stats"
    t.boolean  "unique"
    t.boolean  "untradable"
    t.integer  "category_id"
    t.datetime "synced_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "version"
    t.string   "slug"
  end

  add_index "items", ["category_id"], name: "index_items_on_category_id", using: :btree

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "uid",                       null: false
    t.string   "secret",                    null: false
    t.text     "redirect_uri",              null: false
    t.string   "scopes",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.string   "owner_type"
  end

  add_index "oauth_applications", ["owner_id", "owner_type"], name: "index_oauth_applications_on_owner_id_and_owner_type", using: :btree
  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "poll_items", force: :cascade do |t|
    t.integer  "poll_id"
    t.integer  "position"
    t.string   "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "poll_items", ["poll_id"], name: "index_poll_items_on_poll_id", using: :btree

  create_table "polls", force: :cascade do |t|
    t.integer  "belongs_to_id"
    t.string   "belongs_to_type"
    t.string   "title"
    t.text     "description"
    t.datetime "closes_at"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "polls", ["belongs_to_type", "belongs_to_id"], name: "index_polls_on_belongs_to_type_and_belongs_to_id", using: :btree

  create_table "rsvps", force: :cascade do |t|
    t.integer  "character_id"
    t.integer  "event_id"
    t.date     "date"
    t.boolean  "answer"
    t.string   "comment"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "rsvps", ["character_id"], name: "index_rsvps_on_character_id", using: :btree
  add_index "rsvps", ["date"], name: "index_rsvps_on_date", using: :btree
  add_index "rsvps", ["event_id"], name: "index_rsvps_on_event_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false, null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "characters", "users"
  add_foreign_key "poll_items", "polls"
  add_foreign_key "rsvps", "characters"
  add_foreign_key "rsvps", "events"
end

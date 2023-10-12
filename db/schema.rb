# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_10_12_054454) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "aws_model_configs", force: :cascade do |t|
    t.string "version", null: false
    t.integer "model_type", null: false
    t.string "dataset", null: false
    t.string "description"
    t.integer "promotion_percentage"
    t.string "event_tracker_id", null: false
    t.string "user_dataset_arn", null: false
    t.string "item_dataset_arn", null: false
    t.string "campaign_arn", null: false
    t.string "filter_exclude_category_name", null: false
    t.string "filter_only_category_products_arn", null: false
    t.string "filter_exclude_category_arn", null: false
    t.string "filter_remove_purchases_arn", null: false
    t.string "filter_purchases_arn", null: false
    t.string "filter_only_views_arn", null: false
    t.string "filter_only_apply_arn", null: false
    t.boolean "is_active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "filter_only_provider_channel_products_arn"
    t.string "trending_campaign_arn"
    t.string "filter_exclude_viewed"
    t.string "filter_blog_only"
    t.string "filter_similar_products_arn"
  end

  create_table "categories", force: :cascade do |t|
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_products", id: false, force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "product_id"
    t.index ["category_id"], name: "index_categories_products_on_category_id"
    t.index ["product_id"], name: "index_categories_products_on_product_id"
  end

  create_table "life_stage_recommendation_lists", force: :cascade do |t|
    t.string "life_stage", null: false
    t.jsonb "items"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["life_stage"], name: "index_life_stage_recommendation_lists_on_life_stage", unique: true
  end

  create_table "messages", force: :cascade do |t|
    t.string "title"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "slug"
    t.string "provider"
    t.string "channel"
    t.integer "popularity"
    t.integer "business_rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "popularity_percentage"
  end

  create_table "provider_scores", force: :cascade do |t|
    t.string "provider_slug"
    t.string "channel_slug"
    t.decimal "score", precision: 4, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchase_histories", force: :cascade do |t|
    t.string "user_id", null: false
    t.string "item_id"
    t.string "channel", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_old_purchase", default: false, null: false
    t.index ["user_id"], name: "index_purchase_histories_on_user_id"
  end

  create_table "recommendation_blogs", force: :cascade do |t|
    t.string "title", null: false
    t.string "slug", null: false
    t.string "related_items", default: [], array: true
    t.string "channel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug", "related_items"], name: "blog_item_relationship_index"
    t.index ["slug"], name: "index_recommendation_blogs_on_slug", unique: true
  end

  create_table "recommendation_channel_configs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "deboost_time_in_months"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recommendation_items", force: :cascade do |t|
    t.boolean "is_active", default: false, null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider_slug"
    t.string "channel_slug"
  end

  create_table "recommendation_lists", force: :cascade do |t|
    t.string "channel_slug", null: false
    t.string "product_slug"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recommendation_model_update_logs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "job_type", null: false
    t.string "status", null: false
    t.datetime "from_date", null: false
    t.datetime "to_date", null: false
    t.text "error_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recommendation_users", force: :cascade do |t|
    t.uuid "uuid", null: false
    t.boolean "cold_start", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "seen_life_stage_recommendations", default: false
    t.boolean "seen_socio_demo_recommendations", default: false
    t.datetime "last_interaction_date"
    t.index ["uuid"], name: "index_recommendation_users_on_uuid", unique: true
  end

  create_table "recommendations", force: :cascade do |t|
    t.string "recommendation_id"
    t.uuid "user_id", null: false
    t.string "recommendation_version"
    t.jsonb "details", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "socio_demo_combinations", force: :cascade do |t|
    t.boolean "married", default: false, null: false
    t.boolean "parent", default: false, null: false
    t.boolean "property_owner", default: false, null: false
    t.boolean "vehicle_owner", default: false, null: false
    t.string "owned_property_type"
    t.text "life_stage", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "residential_status"
  end

  create_table "socio_demo_recommendation_relations", force: :cascade do |t|
    t.bigint "socio_demo_recommendation_id", null: false
    t.bigint "socio_demo_combination_id", null: false
    t.integer "rank", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rank", "socio_demo_recommendation_id", "socio_demo_combination_id"], name: "socio_demo_relation_uniq_index", unique: true
    t.index ["socio_demo_combination_id"], name: "socio_demo_combination_index"
    t.index ["socio_demo_recommendation_id"], name: "socio_demo_recommendation_index"
  end

  create_table "socio_demo_recommendations", force: :cascade do |t|
    t.string "user_profile"
    t.string "channel_slugs", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_profile"], name: "index_socio_demo_recommendations_on_user_profile"
  end

  create_table "user_actions", force: :cascade do |t|
    t.string "user_id", null: false
    t.integer "action_type"
    t.integer "recommendation_type"
    t.string "channel_slug"
    t.string "product_slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_actions_on_user_id"
  end

  create_table "user_affinities", force: :cascade do |t|
    t.string "user_id"
    t.string "channel"
    t.float "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wizard_channels", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "image_url"
    t.string "slug"
    t.jsonb "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "similar_items", default: {}
  end

  add_foreign_key "socio_demo_recommendation_relations", "socio_demo_combinations"
  add_foreign_key "socio_demo_recommendation_relations", "socio_demo_recommendations"
end

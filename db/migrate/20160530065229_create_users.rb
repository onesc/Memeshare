class CreateUsers < ActiveRecord::Migration
  def change
    create_table "users", force: :cascade do |t|
      t.text     "name"
      t.text     "email"
      t.text     "bio"
      t.text     "password_digest"
      t.text     "image"
      t.datetime "created_at",      null: false
      t.datetime "updated_at",      null: false
    end
  end
end

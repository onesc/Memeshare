class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :name
      t.text :email
      t.text :bio
      t.text :password_digest
      integer :user_type
      t.text :image

      t.timestamps null: false
    end
  end
end

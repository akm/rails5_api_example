class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :content
      t.string :category
      t.integer :rating

      t.timestamps
    end
  end
end

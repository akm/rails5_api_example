# coding: utf-8
class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts, comment: 'ポスト' do |t|
      t.references :user, null: false, foreign_key: true, comment: 'ユーザ'
      t.string :title   , null: false, comment: 'タイトル'
      t.text :content                , comment: '内容'
      t.string :category             , comment: 'カテゴリ'
      t.integer :rating              , comment: 'レート'

      t.timestamps
    end
  end
end

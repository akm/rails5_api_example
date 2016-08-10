# coding: utf-8
class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users, comment: 'ユーザ' do |t|
      t.string :name           , null: false, comment: 'ユーザ名'
      t.string :password_digest             , comment: 'パスワードダイジェスト'
      t.string :token                       , comment: 'トークン'
      t.text :description                   , comment: '備考'

      t.timestamps
    end
    add_index :users, :token, unique: true
  end
end

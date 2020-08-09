class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :content,null: false
      t.references :user, null: false, foreign_key: true
      t.references :video, null: false, foreign_key: true

      t.timestamps
    end
  end
end

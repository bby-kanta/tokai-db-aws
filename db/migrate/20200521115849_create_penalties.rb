class CreatePenalties < ActiveRecord::Migration[6.0]
  def change
    create_table :penalties do |t|

      t.string :name,null: false
      t.text :description
      t.integer :already,null: false,default: 1
      t.date :since,precision: 8,default: 19980928

      t.references :person,foreign_key: true

      t.timestamps
    end
  end
end

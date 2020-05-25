class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|

      t.string :name, null: false
      t.text :description

      t.references :person,foreign_key: true

      t.timestamps
    end
  end
end

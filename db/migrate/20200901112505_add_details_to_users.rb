class AddDetailsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :description, :text
    add_column :users, :person_id, :integer
    add_column :users, :history, :integer
  end
end

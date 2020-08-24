class AddDetailsToTags < ActiveRecord::Migration[6.0]
  def change
    add_column :tags, :user_id, :integer
  end
end

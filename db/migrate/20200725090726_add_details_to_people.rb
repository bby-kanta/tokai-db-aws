class AddDetailsToPeople < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :person_image_id, :string
  end
end

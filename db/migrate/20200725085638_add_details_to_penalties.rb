class AddDetailsToPenalties < ActiveRecord::Migration[6.0]
  def change
    add_column :penalties, :sort, :string

    add_column :penalties, :penalty_image_id, :string

  end
end

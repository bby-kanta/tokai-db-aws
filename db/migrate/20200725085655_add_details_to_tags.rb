class AddDetailsToTags < ActiveRecord::Migration[6.0]
  def change
    add_column :tags, :sort, :string

    add_column :tags, :tag_image_id, :string

  end
end

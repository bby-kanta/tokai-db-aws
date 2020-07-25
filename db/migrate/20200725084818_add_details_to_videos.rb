class AddDetailsToVideos < ActiveRecord::Migration[6.0]
  def change
    add_column :videos, :sort, :string
  end
end

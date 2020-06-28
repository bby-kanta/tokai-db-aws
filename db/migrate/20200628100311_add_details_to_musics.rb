class AddDetailsToMusics < ActiveRecord::Migration[6.0]
  def change
    add_column :musics, :url, :string
  end
end

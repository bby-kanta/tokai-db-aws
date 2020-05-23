class CreatePlaceVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :place_videos do |t|

      t.references :place,foreign_key: true
      t.references :video,foreign_key: true

      t.timestamps
    end
  end
end

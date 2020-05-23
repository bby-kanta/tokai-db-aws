class CreateMusicVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :music_videos do |t|
      
      t.references :music,foreign_key: true
      t.references :video,foreign_key: true

      t.timestamps
    end
  end
end

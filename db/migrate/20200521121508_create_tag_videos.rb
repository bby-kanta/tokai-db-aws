class CreateTagVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :tag_videos do |t|
      
      t.references :tag,foreign_key: true
      t.references :video,foreign_key: true
      
      t.timestamps
    end
  end
end

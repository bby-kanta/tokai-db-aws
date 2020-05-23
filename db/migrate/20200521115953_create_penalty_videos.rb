class CreatePenaltyVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :penalty_videos do |t|

      t.references :penalty,foreign_key: true
      t.references :video,foreign_key: true

      t.timestamps
    end
  end
end

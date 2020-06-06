class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.references :video,foreign_key: true
      t.references :recommend, foreign_key: { to_table: :videos }
      t.index [:video_id, :recommend_id], unique: true

      t.timestamps
    end
  end
end

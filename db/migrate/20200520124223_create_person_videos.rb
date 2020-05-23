class CreatePersonVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :person_videos do |t|
      
      # referencesは自動で〇〇_idカラムを作り,index:trueにしてくれる！
      t.references :person,foreign_key: true
      t.references :video,foreign_key: true
      # 外部キーを設定すると親のテーブルに無い値を入れられなくなる！

      # referencesを使わない場合
      # t.integer :person_id
      # t.integer :video_id

      t.timestamps
    end
  end
end

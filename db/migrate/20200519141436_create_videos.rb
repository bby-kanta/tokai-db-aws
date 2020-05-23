class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos do |t|
      t.integer :kind_of,precision: 1,default: 0, null: false
      # その動画がメインかサブか個人チャンネルか分ける(0=メイン,1=サブチャン,3=個チャン,4=その他)
      t.string :url,null: false
      # urlには動画のURLを貼る（下11桁の動画IDが格納される）
      t.string :title, null: false
      # titleには動画のタイトルを記述する
      t.integer :rate,precision: 1,default: 3,null: false
      #独断と偏見で4段階評価をつける。4は東海オンエアを知る上で絶対に見なければいけないレベル
      t.text :description,null: false
      # bodyには動画の概要を記述する（ネタバレもあり）
      t.text :highlight,null: false
      # その動画の見所を主観で簡潔にまとめる
      t.integer :category,precision: 2,default: 0
      # 0企画もの、1検証（〜してみたなど）、2コント、3クイズ、4選手権、5王、6文系理系、7旅行、8晩ご飯じゃんけん、9スポーツ系
      t.string :quotes,default: '該当無し'
      # quotesには名言を記述する
      t.integer :mvp,default: 0 
      # 0該当無し,1てつや,2しばゆー,3りょう,4としみつ,5ゆめまる,6虫眼鏡
      t.integer :editor,default: 0
      # 0該当無し,1てつや,2しばゆー,3りょう,4としみつ,5ゆめまる,6虫眼鏡
      t.date :updated_on,precision: 8,null: false,default: 19980928
      #動画がアップロードされた年月を入れる(デフォルトは勘太の誕生日)

      t.timestamps
    end
  end
end


# t.integer :person_id
# t.integer :place_id
# t.integer :penalty_id
# t.integer :tag_id
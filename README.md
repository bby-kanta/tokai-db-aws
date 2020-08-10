# README
# 【このアプリについて】

https://toukaionair.com/

僕が大好きなグループYouTuber「東海オンエア」さんの動画検索アプリです。
東海オンエアは6人組YouTuberです。
現在では***チャンネル登録者500万人***を超えており、独創的なネタとドッキリ動画などをあげる面白さだけで言ったらYouTube界トップだと思っています。

彼らが投稿したたくさんの面白い動画の中でも特に面白い動画を、東海オンエアを初めて見る人・既にファンの人にも見てもらい、***東海オンエアの魅力をもっと伝えたい***。
そのような思いでアプリを制作しました。

YouTubeのトレンドとして、「1日に1本動画をあげること」これはもうマストになってきていてブレイクしているYouTuberはやっぱり毎日投稿をして努力し続けている方ばかりです。
彼ら東海オンエアも毎日投稿をしているYouTuberです。
いくら東海オンエアといえども毎日最高傑作を出し続けることはやっぱり難しいですし正直他の動画と比べると見劣りしてしまう動画もあります。
そのような動画を初めて見る人が見たらせっかく面白い東海オンエアの魅力が伝わらないまま離れていってしまいます。
そこでこのアプリを使うことによって***厳選された最高の動画をすぐに見つけ出す***ことができ魅力を最大限伝えることができます。

# 【アプリの機能について】  
### 僕の独断と偏見でのランク付け  
このアプリの鍵になる機能です。独断と偏見ではありますがランク付けを行うことによって優先して見るべき動画が***一目***でわかります。
 
### 検索・詳細検索・ソート  
ランク別に絞り込むことも可能ですし、ワードでの検索・並び替えも行うことができます。
 
### ハッシュタグ  
これは完全にファンに向けた機能で、あらゆる動画の共通ポイントを言語化することによって見たい動画があるけど、記憶が曖昧で完全に思い出せないときなどに非常に有効です。  
（コード面のことですが中間テーブルを用いたタグ機能で、Gemは使っておりません。）
  
### いいね機能（Vue）  
Twitterのようないいね機能です。いいねした動画を一覧で表示することによって、お気に入りの動画をまとめることができます。  
 
### ログイン機能  
あまりこのアプリに必要はありませんが、いいね機能を使えるようにするためにつけました。  

### 関連動画を表示する機能  
例えば前編・後編があったりする動画に大きな効果を発揮する機能で関連動画が優先して現在見ている記事の一番上に関連動画が表示されるようになっています。  
この機能はYouTubeにももちろんありますが、YouTubeで見るとAIなので完璧ではないです。マニュアルで関連動画を選ぶため100％次に見るべき動画がトップに表示されます。

### 動画が埋め込まれていて記事を開くと自動で再生される機能  
記事を開くと動画が勝手に再生されるのでユーザーに優しい設計です。  
また見所にすぐ飛ぶことができる「時間指定のハイパーリンク」があるのでYouTubeと同じような感覚で見れると思います。その際クリックすると動画がある場所まで自動スクロールします。
 
### レスポンシブデザイン  
スマホからでも快適にアプリを使うことができます
 
### メンバーカラー  
メンバーを象徴する色が一人一人にあるのですが、そのメンバーカラーによってハッシュタグの色が変わるようになっています。
 
# 【使った技術】  
## Ruby on rails 6  　　
WebPackerが便利です。

## Vue.js
SPA化するために使用しました。
railsのAPIモードでJSONをaxiosで送っています。

## AWS (EC2/ALB/Route53/VPC/RDS)
rails+docker+MySQL（RDS）で構築したものをAWSのEC2にSSH接続してデプロイしました。
独自ドメインを獲得し、Route53を使用しました。

## Docker  
最初はHerokuにデプロイしただけだったんですがモダンな技術を使ってみたいという思いからDockerで構築しなおしました。
勉強しているときはいるのかこれと思いましたが使ってみてDockerのすごさを感じ取りました。初期の頃は環境構築で挫折しかけたのですが最初にDockerを学べばそのリスクからは逃れられそうです。

## CircleCI
masterブランチにプッシュされたら、CircleCIからEC2にSSH接続して自動デプロイしDockerComposeを再起動するようにしています。
導入する前はプルリクを飛ばしてマスターブランチにマージ👉EC2にSSH接続👉git pullコマンド👉docker compose restart と手動でやっていたのでとてもストレスでした。

## MySQL  
DBは実務で役立ちそうという思いからMySQLを選択しました。

# Recipe_appの概要
レシピを共有して作りたいレシピを見つけたらすぐに買い物リストを作成できる。スーパーで複数のレシピのページの材料欄を見ながら買い物したり、作りたいレシピのメモを紙に書いてから買い物に出かけなくても、レシピを見ているときに同時に買い物リストを作成できる。

--__URL__--  
[Recipe_app](http://54.249.3.49/)
  
# 利用方法
①レシピ投稿  
・トップページ、ヘッダーーのハンバーガーメニューからテストアカウントでログイン<br>
email: hoge@hoge.com<br>
password: hoge123<br>
・レシピ作成ボタンからレシピを投稿する  
・レシピを一覧画面から確認する  
②買い物リストを作成する  
・レシピ詳細ページから献立追加ボタンを押す  
・ハンバーガーメニューのマイページから献立を確認し、買い物リストに追加するレシピの右側にある➕マークをクリック
・ハンバーガーメニューの買い物リストからリストをチェック（非同期のチェックと削除ができます）

# アプリケーションを作成した背景
普段から料理をするのが好きで、レシピサイトをよく利用していましたが、実際に買い物をするときはいろんなレシピを見ながら買い物をしていて、買い忘れたり余分に買ってしまったりしたことがありました。その時、レシピを見ながら同時に買い物リストを作成してくれるアプリがあったらいいなと思いました。周りの人にも聞いてみると同じ課題を抱えている人がいて、他にも同じ課題を抱えている人がいると推測し開発することにしました。
# 工夫した点
- レシピはログインしていないユーザーでも閲覧できるようにしたこと
- レシピを公開したくないユーザー向けに、自分だけがレシピを確認できるようにしたこと
- レシピの材料の分量をstring型にすることで、ユーザーが自由にレシピの材料を入力できるようにしたこと(integer型の方が計算がしやすい)
- プロフィールやフォロー機能をつけることで、ユーザー同士が繋がる場を作ったこと
- 画像にあらかじめフィルターをつけたり、表示している画像の角を丸くすることで、編集していない画像もおいしく見えるようにしたこと

# 要件定義
[こちらから](https://docs.google.com/spreadsheets/d/1KwSYimefFXwW4nBFSt5P2nJGMS_fz_1ft9eJh8wT1D0/edit#gid=982722306)
# データベース設計
![](https://i.gyazo.com/43b3d2b71e476674accd493319933586.png)
# テーブル設計
## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| name               | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| profile            | string |                           |

### Association

- has_many :recipes
- has_many :comments
- has_many :menus
- has_many  :lists
- has_many :follower
- has_many :followed
- has_many :favorites



## recipes テーブル

| Column    | Type       | Options                        |
| -------   | ---------- | ------------------------------ |
| title     | string     | null: false                    |
| amount    | integer    | null: false                    |
| method    | text       | null: false                    |
| tip       | text       |                                |
| public_id | ineger     | null: false                    |
| user      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :comments
- has_many :ingredients
- has_many :menus
- has_many :favorites  
- has_many :descriptions
*public_idでレシピを一般公開するか自分にしか表示されないかを選択できる。



## ingredients テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| name     | string     | null: false                    |
| quantity | string     | null: false                    |
| recipe   | references | null: false, foreign_key: true |

### Association

- belongs_to :recipe

## descriptions テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| text     | string     | null: false                    |
| recipe   | references | null: false, foreign_key: true |

### Association

- belongs_to :recipe


## lists テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| ingredient_name     | string     | null: false                    |
| ingredient_quantity | string     |                                |
| user                | references | null: false, foreign_key: true |
| check               | integer    | default: 0                     |

### Association

- belongs_to :user



## comments テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| content | string     | null: false                    |
| user    | references | null: false, foreign_key: true |
| recipe  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :recipe


## menusテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| date   | date       | null: false                    |
| recipe | references | null: false, foreign_key: true |
| user   | references | null: false, foreign_key: true |

### Association

- belongs_to :recipe
- belongs_to :user

## relationshipsテーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| follower | references | null: false, foreign_key: true |
| followed | references | null: false, foreign_key: true |

### Association

- belongs_to :follower
- belongs_to :followed


## favoritesテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| recipe | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :recipe

# 画面遷移図
![](https://i.gyazo.com/2d411bf5b2f57855d10718d2c9f2ccd2.png)

# 開発環境
- フロントエンド  
HTML,CSS,JavaScript
- バックエンド  
Ruby
- インフラ  
EC2,S3,
- テスト  
rspec
- テキストエディタ  
VSCode
- タスク管理  
Github
- データベース
mysql,mariadb

# Bon appetiteの概要
レシピを共有して作りたいレシピを見つけたらすぐに買い物リストを作成できる。スーパーで複数のレシピのページの材料欄を見ながら買い物したり、作りたいレシピのメモを紙に書いてから買い物に出かけなくても、レシピを見ているときに同時に買い物リストを作成できる。

--__URL__--  
35.74.89.131

--__テスト用アカウント__--  
|||
| -- | -- |
|  Basic認証パスワード  |  yuki  |
|  Basic認証ID  |  8634  |
|  メールアドレス  |  yuki@yuki.com  |
|  パスワード  |  yuki123  |
  
# 利用方法
①レシピ投稿  
・トップページのヘッダーから新規登録  
・レシピ作成ボタンからレシピを投稿する  
・レシピを一覧画面から確認する  
②買い物リストを作成する  
・レシピ詳細ページから買い物リストに追加ボタンを押す  
・ヘッダーのマイページから買い物リストを確認する  

# アプリケーションを作成した背景
普段から料理をするのが好きで、レシピサイトをよく利用していましたが、実際に買い物をするときはいろんなレシピを見ながら買い物をしていて、買い忘れたり余分に買ってしまったりしたことがありました。その時、レシピを見ながら同時に買い物リストを作成してくれるアプリがあったらいいなと思いました。周りの人にも聞いてみると同じ課題を抱えている人がいて、他にも同じ課題を抱えている人がいると推測し開発することにしました。
# 工夫した点
hoge

# 要件定義

# データベース設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| name               | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |

### Association

- has_many :recipes
- has_many :comments
- has_many :menus
- has_one  :list
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
- has_many :recipe_menus
- has_many :favorites  
*public_idでレシピを一般公開するか自分にしか表示されないかを選択できる。



## ingredients テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| name   | string     | null: false                    |
| recipe | references | null: false, foreign_key: true |

### Association

- belongs_to :recipe


## comments テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| content | string     | null: false                    |
| user    | references | null: false, foreign_key: true |
| recipe  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :recipe

## recipe_menusテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| recipe | references | null: false, foreign_key: true |
| menu   | references | null: false, foreign_key: true |

### Association

- belongs_to :recipe
- belongs_to :menus


## menusテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| date   | date       | null: false                    |
| recipe | references | null: false, foreign_key: true |
| user   | references | null: false, foreign_key: true |

### Association

- has_many :recipe_manus
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

# 開発環境
・フロントエンド
HTML,CSS,JavaScript
・バックエンド
Ruby
・インフラ
EC2,S3,
・テスト
rspec
・テキストエディタ
VSCode
・タスク管理
Github
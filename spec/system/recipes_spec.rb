require 'rails_helper'
def basic_pass(path)
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "Recipes", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @recipe_title = Faker::Lorem.sentence
    @recipe_amount = Faker::Number.number(digits: 2)
    @ingredient_name = Faker::Lorem.word
    @ingredient_quantity = Faker::Number.number(digits: 2)
    @description = Faker::Lorem.sentence
    @tip = Faker::Lorem.sentence
  end

  context "レシピ投稿ができるとき" do
    it "ログインしたユーザーはレシピを投稿できる" do
      # ログインする
      sign_in(@user)
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content "レシピを投稿する"
      # 新規投稿ページへ遷移する
      visit new_recipe_path
      # 投稿フォームに情報を入力する
      fill_in "recipe[title]", with: @recipe_title
      fill_in "recipe[amount]", with: @recipe_amount
      fill_in "recipe[ingredients_attributes][0][name]", with: @ingredient_name
      fill_in "recipe[ingredients_attributes][0][quantity]", with: @ingredient_quantity
      fill_in "recipe[descriptions_attributes][0][text]", with: @description
      fill_in "recipe[tip]", with: @tip
      find("input[name='recipe[public_id]']").click
      # 送信してRecipeモデルのカウントが1増えることを確認する
      expect{
      find("input[name='commit']").click
      }.to change { Recipe.count }.by(1)
      # トップページへ遷移する
      expect(current_path).to eq(root_path)
      # トップページに先ほど投稿した内容が存在することを確認する
      expect(page).to have_content @recipe_title
    end
  end

  context "レシピ投稿ができないとき" do
    it "ログインしていないユーザーはレシピを投稿できない" do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクがないことを確認する
      expect(page).to have_no_content "レシピを投稿する"
      # 新規投稿ページへ遷移しようとすると、トップページに遷移する
      visit new_recipe_path
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

describe "レシピ編集", type: :system do
  before do
    @recipe1 = FactoryBot.create(:recipe)
    @recipe2 = FactoryBot.create(:recipe)
  end

  context "レシピ編集ができるとき" do
    it "ログインしたユーザーは自分のレシピを編集できる" do
      # レシピ１を投稿したユーザーでログインする
      sign_in(@recipe1.user)
      # レシピ１の詳細ページへ遷移する
      visit recipe_path(@recipe1) 
      # 編集ページへ遷移する
      visit edit_recipe_path(@recipe1)
      # 投稿フォームに情報を入力する
      fill_in "recipe[title]", with: "#{@recipe1.title}編集後のタイトル"
      fill_in "recipe[tip]", with: "#{@recipe1.tip}編集後のコツ"
      # 編集してもRecipeモデルのカウントは増えないことを確認する
      expect{
      find("input[name='commit']").click
      }.to change { Recipe.count }.by(0)
      # トップページへ遷移する
      expect(current_path).to eq(recipe_path(@recipe1))
      # トップページには編集後のタイトルが存在することを確認する
      expect(page).to have_content "#{@recipe1.title}編集後のタイトル"
    end
  end

  context "レシピ編集ができないとき" do
    it "ログインしたユーザーは自分以外のレシピを編集できない" do
      # レシピ１を投稿したユーザーでログインする
      sign_in(@recipe1.user)
      # レシピ２の詳細ページへ遷移する
      visit recipe_path(@recipe2) 
      # 編集ボタンがないことを確認する
      expect(page).to have_no_content "編集"
      # 編集ページへ遷移する
      visit edit_recipe_path(@recipe2)
      # トップページへ遷移する
      expect(current_path).to eq(root_path)
    end

    it "ログインしていないユーザーはレシピを編集できない" do
      # トップページに遷移する
      visit root_path
      # レシピの詳細ページへ遷移する
      visit recipe_path(@recipe1)
      # 編集ボタンがないことを確認する
      expect(page).to have_no_content "編集"
      # 編集ページへ遷移する
      visit edit_recipe_path(@recipe1)
      # トップページへ遷移する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

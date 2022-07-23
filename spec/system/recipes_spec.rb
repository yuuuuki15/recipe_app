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
      basic_pass root_path
      find("button[type=button]").click
      expect(page).to have_content "ログイン"
      visit new_user_session_path
      fill_in "Eメール", with: @user.email
      fill_in "パスワード", with: @user.password
      find("input[name='commit']").click
      expect(current_path).to eq(root_path)
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
      expect(page).to have_selector "img[src$='test_image.png']"
      expect(page).to have_content @recipe_title

    end
  end
end

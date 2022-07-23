require 'rails_helper'
def basic_pass(path)
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "Favorites", type: :system do
  before do
    @recipe1 = FactoryBot.create(:recipe)
    @recipe2 = FactoryBot.create(:recipe)
  end

  context "お気に入り登録ができるとき" do
    it "ログインしたユーザーはお気に入り登録できる" do
      basic_pass root_path
      # @recipe1のユーザーでログインする
      sign_in(@recipe1.user)
      # @recipe2の詳細ページに移動する
      visit recipe_path(@recipe2)
      expect(page).to have_selector "input[value='お気に入り登録']"
      # お気に入り登録する
      expect{
      find("input[value='お気に入り登録']").click
      }.to change { Favorite.count }.by(1)
      expect(page).to have_content "お気に入りに登録しました"
    end
  end

  context "お気に入り登録ができないとき" do
    it "ログインしていないユーザーはお気に入り登録できない" do
      # @recipe1の詳細ページに移動する
      visit recipe_path(@recipe1)
      expect(page).to have_no_selector "input[value='お気に入り登録']"
    end

    it "既にお気に入りに登録しているレシピはお気に入り登録できない" do
      basic_pass root_path
      # @recipe1のユーザーでログインする
      sign_in(@recipe1.user)
      # @recipe1の詳細ページに移動する
      visit recipe_path(@recipe1)
      expect(page).to have_selector "input[value='お気に入り登録']"
      # お気に入り登録する
      expect{
      find("input[value='お気に入り登録']").click
      }.to change(Favorite, :count).by(1)
      expect(page).to have_content "お気に入りに登録しました"
      # @recipe1の詳細ページに移動する
      visit recipe_path(@recipe1)
      expect(page).to have_no_selector "input[value='お気に入り登録']"
    end
  end
end

describe "お気に入り削除", type: :system do
  before do
    @recipe1 = FactoryBot.create(:recipe)
    @recipe2 = FactoryBot.create(:recipe)
  end

  context "お気に入り削除ができるとき" do
    it "ログインしているユーザーは自分のお気に入りを削除できる" do
      basic_pass root_path
      # @recipe1のユーザーでログインする
      sign_in(@recipe1.user)
      # @recipe1の詳細ページに移動する
      visit recipe_path(@recipe1)
      expect(page).to have_selector "input[value='お気に入り登録']"
      # お気に入り登録する
      expect{
      find("input[value='お気に入り登録']").click
      }.to change { Favorite.count }.by(1)
      expect(page).to have_content "お気に入りに登録しました"
      # マイページに移動する
      visit user_path(@recipe1.user)
      expect(page).to have_link "削除"
      # お気に入り削除する
      expect{
      click_link "削除"
      }.to change { Favorite.count }.by(-1)
      expect(page).to have_content "お気に入りを解除しました"
    end
  end

  context "お気に入り削除ができないとき" do
    it "ログインしているユーザーでも、他のユーザーのお気に入りを削除できない" do
      basic_pass root_path
      # @recipe1のユーザーでログインする
      sign_in(@recipe1.user)
      # @recipe2の詳細ページに移動する
      visit recipe_path(@recipe2)
      expect(page).to have_selector "input[value='お気に入り登録']"
      # お気に入り登録する
      find("input[value='お気に入り登録']").click
      # ログアウトする
      find("button[type=button]").click
      click_link "ログアウト"
      # @recipe2のユーザーでログインする
      sign_in(@recipe2.user)
      # @recipe1のユーザーのマイページに移動する
      visit user_path(@recipe1.user)
      expect(page).to have_no_link "削除"
    end

    it "ログインしていないユーザーはお気に入り削除できない" do
      # @recipe1のユーザーでログインする
      sign_in(@recipe1.user)
      # @recipe2の詳細ページに移動する
      visit recipe_path(@recipe2)
      find("input[value='お気に入り登録']").click
      # ログアウトする
      find("button[type=button]").click
      click_link "ログアウト"
      # @recipe1のマイページに移動する
      visit user_path(@recipe1.user)
      expect(page).to have_no_link "削除"
    end
  end
end

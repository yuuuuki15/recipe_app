require 'rails_helper'

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
      expect(page).to have_selector "input[value='マイフォルダ']"
      # お気に入り登録する
      expect{
      find("input[value='お気に入り登録']").click
      }.to change { Favorite.count }.by(1)
      expect(page).to have_content "マイフォルダに追加しました"
    end
  end

  context "お気に入り登録ができないとき" do
    it "ログインしていないユーザーはお気に入り登録できない" do
      # @recipe1の詳細ページに移動する
      visit recipe_path(@recipe1)
      expect(page).to have_no_selector "input[value='マイフォルダ']"
    end

    it "既にお気に入りに登録しているレシピはお気に入り登録できない" do
      basic_pass root_path
      # @recipe1のユーザーでログインする
      sign_in(@recipe1.user)
      # @recipe1の詳細ページに移動する
      visit recipe_path(@recipe1)
      expect(page).to have_selector "input[value='マイフォルダ']"
      # お気に入り登録する
      expect{
      find("input[value='マイフォルダ']").click
      }.to change(Favorite, :count).by(1)
      expect(page).to have_content "マイフォルダに追加しました"
      # @recipe1の詳細ページに移動する
      visit recipe_path(@recipe1)
      expect(page).to have_no_selector "input[value='マイフォルダ']"
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
      expect(page).to have_selector "input[value='マイフォルダ']"
      # お気に入り登録する
      expect{
      find("input[value='マイフォルダ']").click
      }.to change { Favorite.count }.by(1)
      expect(page).to have_content "マイフォルダに追加しました"
      # マイフォルダに移動する
      visit favorites_path
      expect(page).to have_link "削除"
      # お気に入り削除する
      expect{
      click_link "削除"
      }.to change { Favorite.count }.by(-1)
      expect(page).to have_content "マイフォルダから削除しました"
    end
  end

  context "お気に入り削除ができないとき" do
    it "ログインしていないユーザーはお気に入り削除できない" do
      # @recipe1のユーザーでログインする
      sign_in(@recipe1.user)
      # @recipe2の詳細ページに移動する
      visit recipe_path(@recipe2)
      find("input[value='マイフォルダ']").click
      # ログアウトする
      find("button[type=button]").click
      click_link "ログアウト"
      # @recipe1のマイページに移動する
      visit user_path(@recipe1.user)
      expect(page).to have_no_link "削除"
    end
  end
end

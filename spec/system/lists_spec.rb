require 'rails_helper'

RSpec.describe "Lists", type: :system do
  before do
    @recipe1 = FactoryBot.create(:recipe)
    @recipe2 = FactoryBot.create(:recipe)
  end

  context "お買い物リストを登録できるとき" do
    it "ログインしたユーザーはお買い物リストに登録できる" do
      basic_pass root_path
      # @recipe1のユーザーでログインする
      sign_in(@recipe1.user)
      # @recipe2の詳細ページに移動する
      visit recipe_path(@recipe2)
      # 献立に追加する
      find("button[id='pull-down']").click
      find("input[class='date-form']").click
      find("input[class='date-form']").set(Date.today)
      find("input[value='追加する']").click
      # マイページに移動する
      visit user_path(@recipe1.user)
      expect(page).to have_content "➕"
      # 買い物リストに追加する
      ingredients_count = @recipe2.ingredients.count
      expect{
      click_link "➕"
      }.to change { List.count }.by(ingredients_count)
      expect(page).to have_content "リストを追加しました"
    end
  end

  context "お買い物リストを追登録できないとき" do
    it "ログインしているユーザーでも他のユーザーの買い物リストは追加できない" do
      # @recipe1のユーザーでログインする
      sign_in(@recipe1.user)
      # @recipe2の詳細ページに移動する
      visit recipe_path(@recipe2)
      # 献立に追加する
      find("button[id='pull-down']").click
      find("input[class='date-form']").click
      find("input[class='date-form']").set(Date.today)
      find("input[value='追加する']").click
      # ログアウトする
      find("button[type=button]").click
      click_link "ログアウト"
      # @recipe2のユーザーでログインする
      sign_in(@recipe2.user)
      # @recipe1のユーザーのマイページに移動する
      visit user_path(@recipe1.user)
      expect(page).to have_no_content "➕"
    end
  end
end

describe "リスト削除", type: :system do
  before do
    @recipe1 = FactoryBot.create(:recipe)
    @recipe2 = FactoryBot.create(:recipe)
  end

  context "お買い物リストを削除できるとき" do
    it "ログインしたユーザーは自分のお買い物リストを削除できる" do
      # @recipe1のユーザーでログインする
      sign_in(@recipe1.user)
      # @recipe2の詳細ページに移動する
      visit recipe_path(@recipe2)
      # 献立に追加する
      find("button[id='pull-down']").click
      find("input[class='date-form']").click
      find("input[class='date-form']").set(Date.today)
      find("input[value='追加する']").click
      # マイページに移動する
      visit user_path(@recipe1.user)
      expect(page).to have_content "➕"
      # 買い物リストに追加する
      ingredients_count = @recipe2.ingredients.count
      expect{
      click_link "➕"
      }.to change { List.count }.by(ingredients_count)
      # 買い物リストに移動する
      find("button[type=button]").click
      click_link "買い物リスト"
      # 買い物リストから削除する
      binding.pry
      find(svg).click
      expect(page).to have_content "買い物リストを削除しました"
    end
  end
end


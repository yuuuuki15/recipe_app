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
      
  end
end

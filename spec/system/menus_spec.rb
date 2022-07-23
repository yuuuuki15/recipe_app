require 'rails_helper'
def basic_pass(path)
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "献立追加", type: :system do
  before do
    @recipe1 = FactoryBot.create(:recipe)
    @recipe2 = FactoryBot.create(:recipe)
  end

  context "献立追加ができるとき" do
    it "ログインしたユーザーは献立追加できる" do
      basic_pass root_path
      # @recipeのユーザーでログインする
      sign_in(@recipe1.user)
      # @recipeの詳細ページに移動する
      visit recipe_path(@recipe1)
      expect(page).to have_content "献立追加"
      # 献立追加する
      expect{
      find("button[id='pull-down']").click
      find("input[class='date-form']").click
      find("input[class='date-form']").set(Date.today)
      find("input[value='追加する']").click
      }.to change { Menu.count }.by(1)
      expect(page).to have_content "献立を追加しました"
    end
  end

  context "献立追加ができないとき" do
    it "ログインしていないユーザーは献立追加できない" do
      # @recipeの詳細ページに移動する
      visit recipe_path(@recipe1)
      expect(page).to have_no_content "献立追加"
    end
  end
end

describe "献立削除", type: :system do
  before do
    @recipe1 = FactoryBot.create(:recipe)
    @recipe2 = FactoryBot.create(:recipe)
  end

  context "献立削除ができるとき" do
    it "ログインしたユーザーは自分の献立を削除できる" do
      basic_pass root_path
      # @recipeのユーザーでログインする
      sign_in(@recipe1.user)
      # @recipeの詳細ページに移動する
      visit recipe_path(@recipe1)
      expect(page).to have_content "献立追加"
      # 献立追加する
      expect{
      find("button[id='pull-down']").click
      find("input[class='date-form']").click
      find("input[class='date-form']").set(Date.today)
      find("input[value='追加する']").click
      }.to change { Menu.count }.by(1)
      expect(page).to have_content "献立を追加しました"
      # マイページに移動する
      visit user_path(@recipe1.user)
      # 献立を削除する
      

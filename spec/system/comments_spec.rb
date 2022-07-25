require 'rails_helper'

RSpec.describe "Comments", type: :system do
  before do
    @recipe1 = FactoryBot.create(:recipe)
    @recipe2 = FactoryBot.create(:recipe)
  end

  context "コメントができるとき" do
    it "ログインしたユーザーはコメントを投稿できる" do
      basic_pass root_path
      # @recipe1のユーザーでログインする
      sign_in(@recipe1.user)
      # @recipe2の詳細ページに移動する
      visit recipe_path(@recipe2)
      expect(page).to have_selector "input[name='commit']"
      expect(page).to have_selector "textarea[name='comment[content]']"
      # コメントを投稿する
      fill_in "comment_content", with: "コメントです"
      expect{
      find("input[name='commit']").click
      }.to change { Comment.count }.by(1)
      expect(page).to have_content "コメントを投稿しました"

    end
  end

  context "コメントができないとき" do
    it "ログインしていないユーザーはコメントを投稿できない" do
      visit recipe_path(@recipe1)
      expect(page).to have_no_selector "input[name='commit']"
      expect(page).to have_no_selector "textarea[name='comment[content]']"
    end
  end
end

describe "コメント削除", type: :system do
  before do
    @comment1 = FactoryBot.create(:comment)
    @comment2 = FactoryBot.create(:comment)
  end

  context "コメント削除できるとき" do
    it "ログインしたユーザーは自分のコメントを削除できる" do
      basic_pass root_path
      # @comment1のユーザーでログインする
      sign_in(@comment1.recipe.user)
      # @comment1のレシピの詳細ページに移動する
      visit recipe_path(@comment1.recipe)
      expect(page).to have_selector "input[name='commit']"
      expect(page).to have_selector "textarea[name='comment[content]']"
      # コメントを投稿する
      fill_in "comment_content", with: "コメントです"
      find("input[name='commit']").click
      expect(page).to have_content "コメントを投稿しました"
      # コメントを削除する
      expect{
      click_link "削除"
      }.to change { Comment.count }.by(-1)
      expect(page).to have_content "コメントを削除しました"
    end
  end

  context "コメント削除できないとき" do
    it "ログインしたユーザーでも他のユーザーのコメントを削除できない" do
      # @comment1のユーザーでログインする
      sign_in(@comment1.recipe.user)
      # @comment2のレシピの詳細ページに移動する
      visit recipe_path(@comment2.recipe)
      expect(page).to have_no_link "削除"
    end

    it "ログインしていないユーザーはコメントを削除できない" do
      visit recipe_path(@comment1.recipe)
      expect(page).to have_no_link "削除"
    end
  end
end

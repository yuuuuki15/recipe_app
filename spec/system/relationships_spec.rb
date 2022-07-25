require 'rails_helper'

RSpec.describe "フォロー", type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
  end

  context "フォローするとき" do
    it "ログインしているユーザーはフォローできる" do
      basic_pass root_path
      # @user1のユーザーでログインする
      sign_in(@user1)
      # @user2の詳細ページに移動する
      visit user_path(@user2)
      expect(page).to have_link "フォローする"
      # フォローする
      expect{
      click_link "フォローする"
      }.to change { Relationship.count }.by(1)
    end
  end

  context "フォローできないとき" do
    it "ログインしていないユーザーはフォローできない" do
      # @user1の詳細ページに移動する
      visit user_path(@user1)
      expect(page).to have_no_link "フォローする"
    end
  end
end

describe "フォロー解除", type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
  end

  context "フォロー解除するとき" do
    it "ログインしているユーザーはフォロー解除できる" do
      basic_pass root_path
      # @user1のユーザーでログインする
      sign_in(@user1)
      # @user2の詳細ページに移動する
      visit user_path(@user2)
      expect(page).to have_link "フォローする"
      # フォローする
      expect{
      click_link "フォローする"
      }.to change { Relationship.count }.by(1)
      # @user2の詳細ページに移動する
      visit user_path(@user2)
      expect(page).to have_link "フォロー外す"
      # フォロー解除する
      expect{
      click_link "フォロー外す"
      }.to change { Relationship.count }.by(-1)
    end
  end

  context "フォロー解除できないとき" do
    it "ログインしていないユーザーはフォロー解除できない" do
      # @user1の詳細ページに移動する
      visit user_path(@user1)
      expect(page).to have_no_link "フォロー外す"
    end
  end
end


require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context "ユーザー新規登録ができるとき" do
    it "正しい情報を入力すればユーザー新規登録ができている" do
      basic_pass root_path
      find("button[type=button]").click
      expect(page).to have_content "新規登録"
      visit new_user_registration_path
      fill_in "名前", with: @user.name
      fill_in "Eメール", with: @user.email
      fill_in "パスワード", with: @user.password
      fill_in "パスワード（確認用）", with: @user.password_confirmation
      expect{
      find("input[name='commit']").click
      }.to change { User.count }.by(1)
      expect(current_path).to eq(root_path)
      find("button[type=button]").click
      expect(page).to have_content "ログアウト"
      expect(page).to have_content "マイページ"
      expect(page).to have_content "買い物リスト"
    end
  end

  context "ユーザー新規登録ができないとき" do
    it "正しい情報を入力しないとユーザー新規登録ができない" do
      basic_pass root_path
      find("button[type=button]").click
      expect(page).to have_content "新規登録"
      visit new_user_registration_path
      fill_in "名前", with: ""
      fill_in "Eメール", with: ""
      fill_in "パスワード", with: ""
      fill_in "パスワード（確認用）", with: ""
      expect{
      find("input[name='commit']").click
      }.to change { User.count }.by(0)
      expect(current_path).to eq(user_registration_path)
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context "ログインができるとき" do
    it "保存されているユーザーの情報と合致すればログインできる" do
      basic_pass root_path
      find("button[type=button]").click
      expect(page).to have_content "ログイン"
      visit new_user_session_path
      fill_in "Eメール", with: @user.email
      fill_in "パスワード", with: @user.password
      find("input[name='commit']").click
      expect(current_path).to eq(root_path)
      find("button[type=button]").click
      expect(page).to have_content "ログアウト"
      expect(page).to have_content "マイページ"
      expect(page).to have_content "買い物リスト"
    end
  end

  context "ログインができないとき" do
    it "保存されているユーザーの情報と合致しないとログインできない" do
      basic_pass root_path
      find("button[type=button]").click
      expect(page).to have_content "ログイン"
      visit new_user_session_path
      fill_in "Eメール", with: ""
      fill_in "パスワード", with: ""
      find("input[name='commit']").click
      expect(current_path).to eq(user_session_path)
    end
  end
end

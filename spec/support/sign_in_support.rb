module SignInSupport
  def sign_in(user)
    basic_pass root_path
    find("button[type=button]").click
    expect(page).to have_content "ログイン"
    visit new_user_session_path
    fill_in "Eメール", with: user.email
    fill_in "パスワード", with: user.password
    find("input[name='commit']").click
    expect(current_path).to eq(root_path)
  end
end
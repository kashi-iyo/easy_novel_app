require 'rails_helper'

RSpec.feature "Posts", type: :feature do

  scenario "ユーザーが新規投稿する" do

    user_a = FactoryBot.create(:user)
    login_as user_a


    expect {
      click_link "新規投稿"
      fill_in "タイトル", with: "新規投稿"
      fill_in "あらすじ", with: "新規投稿のテスト"
      fill_in "本文", with: "ユーザーが新規投稿を行うテストです"
      click_button "登録する"

      expect(page).to have_content "投稿が完了しました"
      expect(page).to have_content "新規投稿"
      expect(page).to have_content "新規投稿のテスト"
    }.to change(user_a.posts, :count).by(1)
  end


end

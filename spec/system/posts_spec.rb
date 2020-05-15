require 'rails_helper'

describe '投稿管理機能', type: :system do
  describe '一覧表示機能' do
    before do
      user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
      FactoryBot.create(:post, title: '最初の投稿', user: user_a)
    end
    it 'ユーザーAが作成した投稿が表示される' do
      expect(page).to have_content '最初の投稿'
    end
    # context 'ユーザーAがログインしている時' do
    #   before do
    #     visit login_path
    #     fill_in 'メールアドレス', with: 'a@example.com'
    #     fill_in 'パスワード', with: 'password'
    #     click_button 'ログイン'
    #   end
    #
    # end
  end
end

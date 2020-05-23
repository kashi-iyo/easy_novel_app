require 'rails_helper'

describe '投稿管理機能', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let!(:post_a) { FactoryBot.create(:post, title: '最初の投稿',
                                    description: "あらすじ", content: "本文", user: user_a
                                    )
                }

  before do
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログイン'
  end

  shared_examples_for 'ユーザーAが作成したタスクが表示される' do
    it { expect(page).to have_content '最初の投稿' }
  end

  describe '一覧表示機能' do
    context 'ユーザーAがログインしている時' do
      let(:login_user) { user_a }

      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーAがログインしている時' do
      let(:login_user) { user_a }

      before do
        visit post_path(post_a)
      end

      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end
  end

  describe '新規投稿機能' do
    let(:login_user) { user_a }

    before do
      visit new_post_path
      fill_in 'タイトル', with: post.title
      fill_in 'あらすじ', with: post.description
      fill_in '本文', with: post.content
      click_button '登録する'
    end

    # context '新規投稿画面でタイトルを入力した時' do
    #   let(:post) { post_a }
    #   # let(:post_title, :post_description, :post_content )
    #   # { '新規投稿のテストを書く', 'あらすじ', '' }
    #
    #   it '正常に登録される' do
    #     expect(page).to have_selector '.alert-success', text: '投稿が完了しました'
    #   end
    # end
    #
    # context '新規投稿画面でタイトルを入力しなかった時' do
    #   let(:post) { '' }
    #
    #   it 'エラーとなる' do
    #     within '#error_explanation' do
    #       expect(page).to have_content 'タイトルを入力してください'
    #     end
    #   end
    # end
  end
end

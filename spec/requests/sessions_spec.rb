require 'rails_helper'

RSpec.describe "Sessions", type: :request do

  let(:user_a) { FactoryBot.attributes_for(:user) }
  let(:user_b) { FactoryBot.attributes_for(:user, :invalid_email) }

  describe "ログイン画面表示" do
    it "ログイン画面の表示に成功すること" do
      get login_path
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end

  describe "ログイン機能" do

    let(:user_params) { { sessions: { user: user_a } } }
    let(:invalid_user_params) { { sessions: { user: user_b } } }

    context "認証済みのユーザーの場合" do

      context "有効な属性値で入力した場合" do

        let(:valid_post) { post login_path, params: user_params }

        it "ログインに成功すること" do
          valid_post
          expect(response).to have_http_status "200"
        end

        # it "投稿一覧画面へリダイレクトされること" do
        #   valid_post
        #   expect(response).to redirect_to posts_url
        # end
      end

      context "無効な属性値で入力した場合" do
        it "ログインに失敗すること" do
          post login_path, params: { sessions: { user: user_b } }
          expect(response).to have_http_status "200"
        end
      end
    end
    context "ゲストの場合" do

    end
  end
end

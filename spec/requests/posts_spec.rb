require 'rails_helper'

RSpec.describe "Posts", type: :request do

  let(:user_a) { FactoryBot.create(:user) }
  let(:login_user) { login(user_a) }
  let(:post_a) { FactoryBot.create(:post) }
  let(:new_post) { FactoryBot.attributes_for(:post) }


  describe "newアクション" do
    it "正常なレスポンスを返すこと" do
      get posts_path
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end

  describe "createアクション" do

    context "認証済みのユーザーの場合" do

      context "有効な値の場合" do

        it "投稿を作成できること" do
          # login_user
          # expect {
          #   post posts_path, params: { post: new_post }
          # }.to change(user_a.posts, :count).by(1)      
        end
      end

      context "無効な値の場合" do

      end
    end

    context "ゲストの場合" do
    end
  end
end

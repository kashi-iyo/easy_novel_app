require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let(:user) { FactoryBot.create(:user) }

  context "ログインを必要としないアクション" do

    describe "#index" do

      it "正常にレスポンスを返すこと" do
        get :index
        expect(response).to be_successful
      end
      it "200レスポンスを返すこと" do
        get :index
        expect(response).to have_http_status "200"
      end

    end

  end

  context "ログインを必要とするアクション" do

    let(:login_user) { login(user) }
    let(:other_user) { FactoryBot.create(:user) }
    let(:post_a) { FactoryBot.create(:post) }
    let(:post_params) { FactoryBot.attributes_for(:post) }

    describe "#new" do

      context "ログイン済みユーザーの場合" do
        it "正常にレスポンスを返すこと" do
          login_user
          get :new
          expect(response).to be_successful
        end
        it "200レスポンスを返すこと" do
          login_user
          get :new
          expect(response).to have_http_status "200"
        end
      end

      context "ゲストの場合" do
        it "302レスポンスを返すこと" do
          get :new
          expect(response).to have_http_status "302"
        end
        it "ログイン画面にリダイレクトされる" do
          get :new
          expect(response).to redirect_to login_url
        end
      end
    end

    describe "#show" do

      context "ログイン済みユーザーの場合" do
        it "正常にレスポンスを返す" do
          login_user
          get :show, params: { id: post_a.id }
          expect(response).to be_successful
        end
      end

      context "ゲストの場合" do
        it "ログインページへリダイレクトされる" do
          get :show, params: { id: post_a.id }
          expect(response).to redirect_to login_url
        end
      end

    end

    describe "#create" do

      context "ログイン済みユーザーの場合" do
        it "投稿を作成する" do
          login_user
          expect {
            post :create, params: { post: post_params }
          }.to change(user.posts, :count).by(1)
        end
      end

      context "ゲストの場合" do
        it "302レスポンスを返す" do
          post :create, params: { post: post_params }
          expect(response).to have_http_status "302"
        end
        it "ログインページへリダイレクトする" do
          post :create, params: { post: post_params }
          expect(response).to redirect_to login_url
        end
      end

    end

    describe "#update" do

      let(:update_params) { FactoryBot.attributes_for(:post, title: "更新後のタイトル") }
      let(:other_users_post) { FactoryBot.create(:post, title: "更新前のタイトル", user: other_user,) }

      context "認可されたユーザーの場合" do
        before do
          @user = FactoryBot.create(:user)
          @post = FactoryBot.create(:post, user: @user)
        end
        it "投稿を更新できること" do
          new_params = FactoryBot.attributes_for(:post, title: "更新後のタイトル")
          login @user
          patch :update, params: { id: @post.id, post: new_params }
          expect(@post.reload.title).to eq "更新後のタイトル"
        end
      end
      context "認可されていないユーザーの場合" do
        it "投稿を更新できないこと" do
          login_user
          patch :update, params: { id: other_users_post.id, post: update_params }
          expect(other_users_post.reload.title).to eq "更新前のタイトル"
        end
        it "投稿編集ページへリダイレクトされること" do
          login_user
          patch :update, params: { id: other_users_post.id, post: update_params }
          expect(response).to redirect_to posts_path
        end
      end
    end
  end
end

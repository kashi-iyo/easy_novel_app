require 'rails_helper'

RSpec.describe PostsController, type: :controller do

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

    let(:user) { FactoryBot.create(:user) }
    let(:login_user) { login(user) } #ログイン
    let(:post_a) { FactoryBot.create(:post) } #投稿を作成
    let(:post_params) { FactoryBot.attributes_for(:post) } #投稿のハッシュを作成
    let(:invalid_post) { FactoryBot.attributes_for(:post, :invalid_title) } #無効な投稿のハッシュを作成


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

        context "有効な属性値が入力された場合" do
          it "投稿が正常に作成できること" do
            login_user
            expect {
              post :create, params: { post: post_params }
            }.to change(user.posts, :count).by(1)
          end
        end

        context "無効な属性値が入力された場合" do
          it "投稿が正常に作成できないこと" do
            invalid_post #無効な投稿を作成
            login_user
            expect {
              post :create, params: { post: invalid_post }
            }.to_not change(user.posts, :count)
          end
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

    let(:users_post) { FactoryBot.create(:post, user: user) } #ログインユーザーに所有されている投稿
    let(:update_params) { FactoryBot.attributes_for(:post, title: "更新後のタイトル") } #更新用の投稿を作成
    let(:other_user) { FactoryBot.create(:user) } #別のユーザーを作成
    let(:other_users_post) { FactoryBot.create(:post, title: "更新前のタイトル", user: other_user,) } #他人に所有されている投稿を作成

    describe "#update" do

      context "認可されたユーザーの場合" do
        it "投稿を更新できること" do
          login_user
          patch :update, params: { id: users_post.id, post: update_params }
          expect(users_post.reload.title).to eq "更新後のタイトル"
        end
      end

      context "認可されていないユーザーの場合" do
        it "投稿を更新できないこと" do
          login_user
          patch :update, params: { id: other_users_post.id, post: update_params }
          expect(other_users_post.reload.title).to eq "更新前のタイトル"
        end
        it "投稿一覧ページへリダイレクトされること" do
          login_user
          patch :update, params: { id: other_users_post.id, post: update_params }
          expect(response).to redirect_to posts_path
        end
      end

      context "ゲストの場合" do
        it "302レスポンスを返すこと" do
          patch :update, params: { id: users_post.id, post: update_params }
          expect(response).to have_http_status "302"
        end
        it "ログイン画面へリダイレクトされること" do
          patch :update, params: { id: users_post.id, post: update_params }
          expect(response).to redirect_to login_url
        end
      end
    end

    describe "#destroy" do

      context "認可されたユーザーの場合" do
        it "投稿を削除できること" do
          users_post #ログインユーザーの投稿を作成
          login_user #ログインシミュレート
          expect {
            delete :destroy, params: { id: users_post.id }
          }.to change(user.posts, :count).by(-1)
        end
      end

      context "認可されていないユーザーの場合" do
        before do
          other_users_post #他人の投稿を作成
          login_user #ログインシミュレート
        end
        it "投稿が削除できないこと" do
          expect {
            delete :destroy, params: { id: other_users_post.id }
          }.to_not change(Post, :count)
        end
        it "投稿一覧画面へリダイレクトされること" do
          delete :destroy, params: { id: other_users_post.id }
          expect(response).to redirect_to posts_path
        end
      end

      context "ゲストの場合" do
        before do
          post_a
        end
        it "302レスポンスを返すこと" do
          delete :destroy, params: { id: post_a.id }
          expect(response).to have_http_status "302"
        end
        it "ログイン画面へリダイレクトされること" do
          delete :destroy, params: { id: post_a.id }
          expect(response).to redirect_to login_url
        end
        it "投稿を削除できないこと" do
          expect {
            delete :destroy, params: { id: post_a.id }
          }.to_not change(Post, :count)
        end
      end
    end
  end
end

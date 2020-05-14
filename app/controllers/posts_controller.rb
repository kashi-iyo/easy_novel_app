class PostsController < ApplicationController
  skip_before_action :login_required, only: [:index]

  def index
    @posts = current_user.posts
  end

  def new
    @post = Post.new
  end

# @postインスタンス変数は、エラーメッセージの表示に使う。
  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to @post, notice: "投稿が完了しました。"
    else
      render :new
    end
  end

  def show
    @post = current_user.posts.find(params[:id])
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    post = current_user.posts.find(params[:id])
    post.update!(post_params)
    redirect_to post, notice: "投稿を更新しました。"
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy
    redirect_to posts_path, notice: "投稿を削除しました。"
  end

  private

    def post_params
      params.require(:post).permit(:title, :description, :content)
    end
end

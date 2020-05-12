class PostsController < ApplicationController
  def index

  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.save!
    redirect_to posts_url, notice: "投稿が完了しました。"
  end

  def show
  end

  def edit
  end

  private

    def post_params
      params.require(:post).permit(:title, :description, :content)
    end
end

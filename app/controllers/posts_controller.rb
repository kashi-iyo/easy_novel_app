class PostsController < ApplicationController
  skip_before_action :login_required, only: [:index]
  before_action :set_post, only: [:show, :edit, :update, :destroy]


  def index
    @q = Post.all.ransack(params[:q])
    @posts = @q.result(distinct: true)

    respond_to do |format|
      format.html # HTMLとしてアクセスされた場合に実行される。
      format.csv { send_data @posts.generate_csv,
                   filename: "post-#{Time.zone.now.strftime('%Y%m%d%S')}.csv" }
                   # CSVとしてアクセスされた場合に実行される。
                   # send_dataメソッドを使って、レスポンスを送り出し
                   # 送り出したデータをファイルとしてダウンロードできるようにする。
    end
  end
  # def index
  #   @posts = Post.all.order(created_at: :desc)
  #
  # end

  def new
    @post = Post.new
  end

# @postインスタンス変数は、エラーメッセージの表示に使う。
  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      PostMailer.creation_email(@post).deliver_now
      redirect_to @post, notice: "投稿が完了しました。"
    else
      render :new
    end
  end

  def show
    respond_to do |format|
      format.html # HTMLとしてアクセスされた場合に実行される。
      format.csv { send_data Post.where(id: params[:id]).generate_csv,
                   filename: "post-#{Time.zone.now.strftime('%Y%m%d%S')}.csv" }
                   # CSVとしてアクセスされた場合に実行される。
                   # send_dataメソッドを使って、レスポンスを送り出し
                   # 送り出したデータをファイルとしてダウンロードできるようにする。
    end
  end

  def edit
  end

  def update
    @post.update!(post_params)
    redirect_to post, notice: "投稿を更新しました。"
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました。"
  end

  private

    def post_params
      params.require(:post).permit(:title, :description, :content)
    end

    def set_post
      @post = current_user.posts.find(params[:id])
    end
end

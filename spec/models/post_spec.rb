require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { FactoryBot.create(:user,
                      name: 'Tanaka',
                      email: 'user@example.com',
                      password_digest: 'password'
                      )
                    }

  let(:post_valid) { FactoryBot.create(:post,
                      title: "タイトル",
                      description: "あらすじ",
                      content: "本文",
                      user: user
                      )
                    }

  it "タイトルが存在しなければ無効である" do
    no_title_post = user.posts.build(title: "")
    no_title_post.invalid?
    expect(no_title_post.errors[:title]).to include("を入力してください")
  end

  it "タイトルが重複した場合は無効である" do
    post_valid
    new_post = user.posts.build(title: "タイトル")
    new_post.valid?
    expect(new_post.errors[:title]).to include("はすでに存在します")
  end

  it "タイトルが30文字以上ならば無効である" do
    str = "a" * 31
    over_str_post = user.posts.build(title: "#{str}")
    over_str_post.valid?
    expect(over_str_post.errors[:title]).to include("は30文字以内で入力してください")
  end

  # it "あらすじが存在なければ無効である"
  # it "あらすじが200文字以上ならば無効である"
  # it "本文が存在しなければ無効である"

  it "検索文字列に一致する投稿を返す" do
    
  end
end

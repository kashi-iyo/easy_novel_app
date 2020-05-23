require 'rails_helper'

RSpec.describe Post, type: :model do

  describe "Userモデルのバリデーション" do

    context "バリデーションが有効である場合" do
      it "タイトル、あらすじ、本文が入力されていれば有効である" do
        user = FactoryBot.create(:user)
        post = FactoryBot.create(:post, user: user)
        expect(post).to be_valid
      end

      it "タイトルが30文字ちょうどなら有効である" do
        str = "a" * 30
        length_post = FactoryBot.create(:post, title: "#{str}")
        expect(length_post).to be_valid
      end

      it "あらすじが200文字ちょうどならば有効である" do
        str = "a" * 200
        over_str_post = FactoryBot.build(:post, description: "#{str}")
        expect(over_str_post).to be_valid
      end
    end

    context "バリデーションが無効である場合" do
      it "タイトルが存在しなければ無効である" do
        notitle_post = FactoryBot.build(:post, title: "")
        notitle_post.valid?
        expect(notitle_post.errors[:title]).to include("を入力してください")
      end

      it "タイトルが重複した場合は無効である" do
        post_valid
        new_post = FactoryBot.build(:post, title: "タイトル")
        new_post.valid?
        expect(new_post.errors[:title]).to include("はすでに存在します")
      end

      it "タイトルが30文字以上ならば無効である" do
        str = "a" * 31
        over_str_post = FactoryBot.build(:post, title: "#{str}")
        over_str_post.valid?
        expect(over_str_post.errors[:title]).to include("は30文字以内で入力してください")
      end

      it "あらすじが存在なければ無効である" do
        no_description_post = FactoryBot.build(:post, description: nil)
        no_description_post.valid?
        expect(no_description_post.errors[:description]).to include("を入力してください")
      end

      it "あらすじが200文字以上ならば無効である" do
        str = "a" * 201
        over_str_post = FactoryBot.build(:post, description: "#{str}")
        over_str_post.valid?
        expect(over_str_post.errors[:description]).to include("は200文字以内で入力してください")
      end

      it "本文が存在しなければ無効である" do
        no_content_post = FactoryBot.build(:post, content: nil)
        no_content_post.valid?
        expect(no_content_post.errors[:content]).to include("を入力してください")
      end
    end
  end

  describe "投稿を検索する" do
    context "有効な検索を行った場合" do
      it "検索条件にタイトルが入力された場合は有効である" do
        expect(Post.ransakable_attributes).to include("title")
      end

      it "検索条件に日時が入力された場合は有効である" do
        expect(Post.ransakable_attributes).to include("created_at")
      end
    end

    context "無効な検索を行った場合" do
      it "検索条件にあらすじが入力された場合は無効である" do
        expect(Post.ransakable_attributes).not_to include("description")
      end

      it "検索条件に本文が入力された場合は無効である" do
        expect(Post.ransakable_attributes).not_to include(["content"])
      end

      it "検索条件に意図しない入力があった場合は無効である" do
        expect(Post.ransakable_associations("invalid_word")).to be_empty
      end
    end
  end
end

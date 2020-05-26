require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user_valid) { FactoryBot.create(:user) }

  describe "ユーザーバリデーション" do

    context "バリデーションが有効な場合" do

      it "名前、メールアドレス、パスワードがあれば有効である" do
        expect(user_valid).to be_valid
      end

    end

    context "バリデーションが無効な場合" do

      it "名前がなければ無効である" do
        user = FactoryBot.build(:user, :invalid_name)
        user.valid?
        expect(user.errors[:name]).to include("を入力してください")
      end

      it "メールアドレスがなければ無効である" do
        user = FactoryBot.build(:user, :invalid_email)
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end

      it "パスワードがなければ無効である。" do
        user = FactoryBot.build(:user, :invalid_pass)
        user.valid?
        expect(user.errors[:password_digest]).to include("を入力してください")
      end

      it "メールアドレスが重複している場合は無効である" do
        user_valid
        user_invalid = FactoryBot.build(:user, email: user_valid.email)
        user_invalid.valid?
        expect(user_invalid.errors[:email]).to include("はすでに存在します")
      end
    end
  end
end

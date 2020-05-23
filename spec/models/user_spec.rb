require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_valid) { FactoryBot.create(:user, name: 'Tanaka',
                     email: 'user@example.com',password_digest: 'password')
                   }

  it "名前、メールアドレス、パスワードがあれば有効である" do
    expect(user_valid).to be_valid
  end

  it "名前がなければ無効である" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")

  end

  it "メールアドレスがなければ無効である" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  it "パスワードがなければ無効である。" do
    user = User.new(password_digest: nil)
    user.valid?
    expect(user.errors[:password_digest]).to include("を入力してください")
  end

  it "メールアドレスが重複している場合は無効である" do
    user_valid
    user = User.new(name: "Satou",
                    email: "user@example.com", password_digest: "password")
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end
end

FactoryBot.define do
    factory :user do #factoryメソッドを利用して、:userという名前のUserクラスのファクトリを作成。
      name { 'テストユーザー' }
      email { 'test1@example.com' }
      password { 'password' }
    end
  end

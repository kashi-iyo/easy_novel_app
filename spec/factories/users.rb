FactoryBot.define do
    factory :user do #factoryメソッドを利用して、:userという名前のUserクラスのファクトリを作成。
      name { 'テストユーザー' }
      sequence(:email) { |n| "test#{n}@example.com" }
      password { 'password' }
    end
  end

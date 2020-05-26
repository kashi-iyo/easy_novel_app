FactoryBot.define do
    factory :user do #factoryメソッドを利用して、:userという名前のUserクラスのファクトリを作成。
      name { 'テストユーザー' }
      sequence(:email) { |n| "test#{n}@example.com" }
      password { 'password' }

      trait :invalid_name do
        name { nil }
      end

      trait :invalid_email do
        email { nil }
      end

      trait :invalid_pass do
        password { nil }
      end
    end
  end

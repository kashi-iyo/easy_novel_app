FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "タイトル #{n}" }
    description { 'あらすじ' }
    content { '本文' }
    user

    trait :invalid do
      title { nil }
    end

  end
end

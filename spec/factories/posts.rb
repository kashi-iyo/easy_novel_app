FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "タイトル #{n}" }
    description { 'あらすじ' }
    content { '本文' }
    user

    trait :invalid_title do
      title { nil }
    end

    trait :invalid_description do
      description { nil }
    end

    trait :invalid_content do
      content { nil }
    end
  end
end

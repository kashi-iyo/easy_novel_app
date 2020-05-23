FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "タイトル #{n}" }
    description { 'あらすじ' }
    content { '本文' }
    user

  end
end

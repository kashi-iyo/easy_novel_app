FactoryBot.define do
  factory :post do
    title { 'テストを書く' }
    description { 'あらすじ' }
    content { '本文' }
    user
  end
end

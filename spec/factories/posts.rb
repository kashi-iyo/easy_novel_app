FactoryBot.define do
  factory :post do
    title { 'タイトル' }
    description { 'あらすじ' }
    content { '本文' }
    user
  end
end

FactoryBot.define do
  factory :book do
    title { "おいしいミシシッピズワイガニの焼き方"}
    introduction { "伝説のミシシッピズワイガニを食べよう。味わおう。" }
    price { 1000 }

    association :user
  end
end
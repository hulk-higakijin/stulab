FactoryBot.define do
  factory :user do
    name { "野生のミシシッピズワイガニ" }
    email { "kanikani.zuwai@example.com" }
    password { "kanikanizuwai" }
    password_confirmation { "kanikanizuwai" }
  end
end
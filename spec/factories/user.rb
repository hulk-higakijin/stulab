FactoryBot.define do
  factory :user do
    name { "野生のミシシッピズワイガニ" }
    email { "kanikani.zuwai@example.com" }
    password { "kanikanizuwai" }
    password_confirmation { "kanikanizuwai" }
  end

  factory :author, class: User do
    name { "伝説作家のミシシッピズワイガニ" }
    email { "kanikani.legend@example.com" }
    password { "kanikanilegend" }
    password_confirmation { "kanikanilegend" }
    author { true }
  end
end
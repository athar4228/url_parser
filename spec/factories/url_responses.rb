FactoryBot.define do
  factory :url_response do
    url Faker::Internet.url
    content { { h1: [Faker::Lorem.word], h2: [Faker::Lorem.word], h3: [Faker::Lorem.word], anchors: [Faker::Internet.url] } }
  end
end

FactoryBot.define do
  factory :user, class: User do
    provider { 'github' }
    uid { SecureRandom.hex(4) }
    sequence(:name) { |n| "user#{n}" }
    sequence(:login) { |n| "login#{n}" }
    sequence(:email) { |n| "user#{n}@gmail.com" }
    image_url { 'https://avatars3.githubusercontent.com/u/11058676?v=4' }
  end
end
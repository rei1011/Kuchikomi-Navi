# frozen_string_literal: true

FactoryBot.define do
  factory :room do
    association :user
    trait :with_store1 do
      association :store1, factory: :store
    end
    trait :with_store2 do
      association :store2, factory: :store
    end
    trait :with_store do
      association :store1, factory: :store
      association :store2, factory: :store
    end
  end
end

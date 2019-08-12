FactoryBot.define do
  factory :task do
    sequence(:name) { |s| "Name#{s}" }
    sequence(:description) { |s| "Description#{s}" }
    association :author, factory: :manager
    association :assignee, factory: :developer
  end
end

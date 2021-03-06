FactoryBot.define do
  factory :contact do
    sequence(:name) { |n| "Contact_name_#{n}" }
    sequence(:email) { |n| "admin#{n}@admin.com" }
    phone { '(55) 77777-8888' }
    institution
  end
end

FactoryBot.define do
  factory :comment do
    comment_content { "MyString" }
    user { nil }
    video { nil }
  end
end

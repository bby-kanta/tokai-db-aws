FactoryBot.define do
  factory :video do
    title {"タイトルです"}
    url {"abcd1234"}
    description {"概要です"}
    highlight {"見所です"}
    rate {1}
    kind_of {1}
    mvp {1}
    editor {1}
    quotes {"名言です"}
    updated_on {2020-07-15}
  end
end

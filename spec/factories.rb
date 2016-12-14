FactoryGirl.define do

  factory :user, aliases: [:author] do
    sequence(:name) { |n| "foo#{n}" }
    sequence(:email) { "#{name}@bar.com" }
    password  "foobar"

    trait :blank_name do
      name ''
    end

    trait :non_default_name do
      name "oof"
    end
  end

  factory :secret do
    title "foo title"
    body "foo body"
    author
  end

end

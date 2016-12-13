FactoryGirl.define do
<<<<<<< HEAD

  factory :user, aliases: [:author] do
    sequence(:name) { |n| "foo#{n}" }
    email { "#{name}@bar.com" }
    password "foobar"
  end

  factory :secret do
    title "Secret Title"
    body "This is a secret body."
    author
  end

end
=======
  factory :user, aliases: [:author] do
    sequence(:name) { |n| "foo#{n}" }
    sequence(:email) { |n| "#{name}@bar.com" }
    password  "foobar"
  end

  factory :secret do
    title     "foo title"
    body      "foo body"
    author
  end
end
>>>>>>> feature_testing

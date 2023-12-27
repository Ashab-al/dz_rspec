FactoryBot.define do
  factory :task do
    title { "Task 1" }
    description { "asdasdasdasd asdasd  asdasd" }
    completed { false }
  end
  factory :empty_task do
    title { "" }
    description { "" }
    completed { nil }
  end

  factory :task_list, class Task do 
    sequence(:title) { |n| "Task #{n}" }
    description { "asdasdasdasdasdasd" }
    completed { true }
  end
end

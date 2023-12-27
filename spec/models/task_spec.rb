require 'rails_helper'

RSpec.describe Task, type: :model do
  it "is valid with attributes" do
    task = build(:task)
    expect(task).to be_valid
  end

  it "is not valid without title" do
    task = build(:task, title: nil)
    expect(task).to_not be_valid
  end

  it "is not valid without attributes" do
    task = build(:empty_task)
    expect(task).to_not be_valid
  end
end

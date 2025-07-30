require 'rails_helper'

RSpec.describe Category, type: :model do
  it "is invalid without a name" do
    category = Category.new
    expect(category).to be_invalid
    expect(category.errors[:name]).to be_present
  end

  it "requires unique name" do
    Category.create!(name: 'Cardiology')
    dup = Category.new(name: 'Cardiology')
    expect(dup).to be_invalid
    expect(dup.errors[:name]).to be_present
  end
end

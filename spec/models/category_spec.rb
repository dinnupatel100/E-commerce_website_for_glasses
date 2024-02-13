require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations on category' do
    subject { FactoryBot.build(:category) }

    it "should be valid category with all attributes" do
      expect(subject).to be_valid
    end

    it "should not be valid without category name" do
      subject.category_name = nil
      expect(subject).to_not be_valid
    end

    it 'should not be valid with a category name that is not unique' do
      subject.save
      category_name = subject.category_name
      duplicate_category = FactoryBot.build(:category, category_name: category_name)
      expect(duplicate_category).to_not be_valid
    end
  end
end
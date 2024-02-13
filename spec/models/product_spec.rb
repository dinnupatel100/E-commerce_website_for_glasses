require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validation' do
    subject { FactoryBot.build(:product) }
  
    it "should be valid with all attributes" do
      expect(subject).to be_valid
    end

    it "should not be valid without a size" do
      subject.size = nil
      expect(subject).to_not be_valid
    end

    it "should not be valid without a quantity" do
      subject.quantity = nil
      expect(subject).to_not be_valid
    end

    it "should not be valid with a quantity less than 1" do
      subject.quantity = 0
      expect(subject).to_not be_valid
    end

    it "should not be valid without a product color" do
      subject.product_color = nil
      expect(subject).to_not be_valid
    end

  end
end
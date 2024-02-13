require 'rails_helper'

RSpec.describe ProductColor, type: :model do
  describe 'validation' do
    subject { FactoryBot.build(:product_color) }

    it "should be valid with all attributes" do
      expect(subject).to be_valid
    end

    it "should not be valid without a color name" do
      subject.color = nil
      expect(subject).to_not be_valid
    end

    it "should not be valid without a product details" do
      subject.product_detail = nil
      expect(subject).to_not be_valid
    end

  end
end
require 'rails_helper'

RSpec.describe OrdersProduct, type: :model do
  describe 'validation' do
    subject { FactoryBot.build(:orders_product) }

    it "should be valid with all attributes" do
      expect(subject).to be_valid
    end

    it "should not be valid without quantity" do
      subject.quantity = nil
      expect(subject).to_not be_valid
    end

    it "should not be valid with quantity less than 1" do
      subject.quantity = 0
      expect(subject).to_not be_valid
    end

    it "should not be valid without order" do
      subject.order = nil
      expect(subject).to_not be_valid
    end

    it "should not be valid without product" do
      subject.product = nil
      expect(subject).to_not be_valid
    end

  end
end

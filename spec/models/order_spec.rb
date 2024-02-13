require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validation' do
    subject { FactoryBot.build(:order) }
  
    it "should be valid with all attributes" do
      expect(subject).to be_valid
    end

    it "should not be valid without a order status" do
      subject.order_status = nil
      expect(subject).to_not be_valid
    end

    it "should not be valid without a total price" do
      subject.total_bill = nil
      expect(subject).to_not be_valid
    end

    it "should not be valid with total bill  less than 0" do
      subject.total_bill = -5.0
      expect(subject).to_not be_valid
    end

    it "should not be valid without a user" do
      subject.user = nil
      expect(subject).to_not be_valid
    end

  end
end

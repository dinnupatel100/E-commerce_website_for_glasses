require 'rails_helper'

RSpec.describe Review, type: :model do
  
  describe 'validation' do
    subject { FactoryBot.build(:review) }

    it "should be valid with all attributes" do
      expect(subject).to be_valid
    end

    it "should not be valid without rating" do
      subject.rating = nil
      expect(subject).to_not be_valid
    end

    it "should not be valid without a review message" do
      subject.review_message = nil
      expect(subject).to_not be_valid
    end

    it "should not be valid without user" do
      subject.user = nil
      expect(subject).to_not be_valid
    end

    it "should not be valid without product detail" do
      subject.product_detail = nil
      expect(subject).to_not be_valid
    end

    it "should not be valid with rating less than 1" do
      subject.rating = 0.8
      expect(subject).to_not be_valid
    end

    it "should not be valid with rating greater than 5" do
      subject.rating = 5.8
      expect(subject).to_not be_valid
    end

  end
end

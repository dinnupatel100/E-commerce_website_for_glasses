require 'rails_helper'

RSpec.describe ProductDetail, type: :model do

  describe 'validations on product details' do
    subject { FactoryBot.build(:product_detail) }

    it 'should be valid for all attributes' do
      expect(subject).to be_valid
    end

    it "should not be valid without a product name" do
      subject.product_name = nil
      expect(subject).to_not be_valid
    end

    it "should not be valid without a product description name" do
      subject.product_description = nil
      expect(subject).to_not be_valid
    end

    it "should not be valid without a cost price" do
      subject.cost_price = nil
      expect(subject).to_not be_valid
    end

    it "should not be valid without a selling price" do
      subject.selling_price = nil
      expect(subject).to_not be_valid
    end

    it "should not be valid without a brand name" do
      subject.brand = nil
      expect(subject).to_not be_valid
    end

    it "should not be valid without category" do
      subject.category = nil
      expect(subject).to_not be_valid
    end

    it "should not be valid with product name that is not unique" do
      subject.save
      product_name = subject.product_name
      duplicate_user = FactoryBot.build(:product_detail, product_name: product_name)
      expect(duplicate_user).to_not be_valid
    end
    
    it "should not be valid with cost price less than 0" do
      subject.cost_price = -1.2
      expect(subject).to_not be_valid
    end

    it "should not be valid with selling price less than 0" do
      subject.selling_price = -1.2
      expect(subject).to_not be_valid
    end

  end
end

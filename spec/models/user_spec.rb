require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    subject { FactoryBot.build(:user) }

    it "should be valid user with all attributes" do
      expect(subject).to be_valid
    end

    it "should not be valid without a first name" do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

    it "should not be valid without a email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it "should not be valid without a password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it "should not valid be without a date of birth" do
      subject.dob = nil
      expect(subject).to_not be_valid
    end

    it "should not be valid without a address" do
      subject.address = nil
      expect(subject).to_not be_valid
    end

    it "should not be valid without a mobile number" do
      subject.mobile_no = nil
      expect(subject).to_not be_valid
    end

    it "should not be valid without a city" do
      subject.city = nil
      expect(subject).to_not be_valid
    end

    it "should not be valid without postal code" do
      subject.postal_code = nil
      expect(subject).to_not be_valid
    end

    it 'should not be valid with a mobile_no less than 10' do
      subject.mobile_no = "92842827"
      expect(subject).to_not be_valid
    end

    it 'should not be valid with a mobile_no greater than 15' do
      subject.mobile_no = "928428272625242342"
      expect(subject).to_not be_valid
    end

    it 'should not be valid with a mobile_no that is not a number' do
      subject.mobile_no = "928428abc"
      expect(subject).to_not be_valid
    end

    it 'should not be valid with a password less than 6' do
      subject.password = "pass"
      expect(subject).to_not be_valid
    end

    it 'should not be valid with a password greater than 15' do
      subject.password = "password1234567890"
      expect(subject).to_not be_valid
    end

    it 'should not be valid with a postal code less than 6 digit' do
      subject.postal_code = "12345"
      expect(subject).to_not be_valid
    end

    it 'should not be valid with a mobile number that is not unique' do
      subject.save
      phno = subject.mobile_no
      duplicate_user = FactoryBot.build(:user, mobile_no: phno)
      expect(duplicate_user).to_not be_valid
    end

    it 'should not be valid with a email that is not unique' do
      subject.save
      email = subject.email
      duplicate_user = FactoryBot.build(:user, email: email)
      expect(duplicate_user).to_not be_valid
    end
  end
end

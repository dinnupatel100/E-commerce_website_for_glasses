require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  
  before do
    @user = FactoryBot.create(:user)
    add_headers(@user)
  end

  describe "PUT update_user" do
    context "when user_params are valid" do
      it "updates user" do
        put 'update', params: { id: @user.id , user:{ first_name: 'Dinesh'}}
        expect(response).to have_http_status(:ok)
      end
    end
    context "when user_params are not valid" do
      it "returns user not found" do
        put 'update', params: { id:1342, user:{ first_name: 'Dinesh'} }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "POST create user" do
    context "user created" do
      it "user signup" do
        post 'create', params: { user: {first_name: "Dinesh", last_name:"Patel", password:"dinnu100", email:"dinnu@gmail.com", dob:"2000-11-10", mobile_no:"9286272628", address:"dgh", city:"Pune", postal_code:411017}}
        expect(response).to have_http_status(:created)
      end
    end
    context "user not created" do
      it "signup failed" do
        post 'create', params: { user: {last_name:"Patel", password:"dinnu100", email:"dinu@gmail.com", dob:"2000-11-10", mobile_no:"9286272625", address:"dgh", city:"Pune", postal_code:411017}}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe "POST login user" do
    context "when login params are valid" do
      it "user login" do
        post 'login', params: { user: { password:"dinnu100", email:"dinu@gmail.com"}}
        expect(response).to have_http_status(:accepted)
      end
    end
    context "when login params are not valid" do
      it "user login" do
        post 'login', params: { user: {password:"dindnu100", email:"dinu@gmail.com"}}
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE user" do
    context "when param id is valid" do
      it "user delete" do
        delete 'destroy', params: { id: @user.id}
        expect(response).to have_http_status(:ok)
      end
    end
    context "when param id is not valid" do
      it "user not deleted" do
        delete 'destroy', params: { id: 789}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe "GET user index" do
    context "when users are found" do
      it "returns users" do
        get :index
        expect(response).to have_http_status(:ok)
      end
    end
  end


end
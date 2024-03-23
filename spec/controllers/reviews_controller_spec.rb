require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  
  before do
    @user = FactoryBot.create(:user)
    add_headers(@user)
    @product_details = FactoryBot.create(:product_detail)
    @review = FactoryBot.create(:review)
    @review.update(product_detail_id: @product_details.id)
  end

  describe "POST Reviews" do
    context "with all valid parameters" do
      it "create review" do
        post 'create', params: {review:{rating: 4.5, review_message: "Nice"}, id: @product_details.id}
        expect(response).to have_http_status(:created)
      end
    end
    context "with invalid valid parameters" do
      it "review not created" do
        post 'create', params: {review:{rating: 4.5, review_message: nil}, id: @product_details.id}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe "GET show reviews" do
    context "with all valid parameters" do
      it "show review" do
        get 'show_product_reviews', params: { id: @product_details.id }
        expect(response).to have_http_status(:ok)
      end
    end
    context "with invalid valid parameters" do
      it "review not found" do
        get 'show_product_reviews', params: { id: 789}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
  
end
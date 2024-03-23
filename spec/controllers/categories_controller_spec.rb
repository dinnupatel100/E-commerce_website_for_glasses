require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  
  before do
    @user = FactoryBot.create(:user)
    @user.update(role: "admin")
    add_headers(@user)
    @category = FactoryBot.create(:category)
    @product_details = FactoryBot.create(:product_detail)
    @product_details.update(category_id: @category.id)
  end

  describe "Category" do
    context "GET category data" do
      it "data present" do
        get 'index'
        expect(response).to have_http_status(:ok)
      end
    end

    context "POST add category data" do
      it "category valid params" do
        post 'add_category', params:{ category:{category_name:"New"} }
        expect(response).to have_http_status(:created)
      end
      it "category Invalid params" do
        post 'add_category', params:{ category:{category_name:nil} }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context "GET show category products" do
      it "category valid id" do
        get 'show_category_products', params: { id: @category.id }
        expect(response).to have_http_status(:ok)
      end
      it "category invalid id" do
        get 'show_category_products', params:{ id: 90}
        expect(response).to have_http_status(:not_found)
      end
    end

    context "DELETE delete category" do
      it "category valid id" do
        delete 'destroy', params: { id: @category.id }
        expect(response).to have_http_status(:ok)
      end
      it "category invalid id" do
        delete 'destroy', params:{ id: 90}
        expect(response).to have_http_status(:not_found)
      end
    end

    context "UPDATE category" do
      it "category valid id" do
        put 'update', params: { id: @category.id, category:{ category_name:"vdjj" } }
        expect(response).to have_http_status(:ok)
      end
      it "category invalid id" do
        delete 'destroy', params:{ id: 90}
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
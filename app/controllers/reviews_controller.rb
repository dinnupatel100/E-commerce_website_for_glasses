class ReviewsController < ApplicationController
  load_and_authorize_resource
  
  def index
  end

  def create
    review = Review.new(review_params.merge(user_id: current_user.id, product_detail_id: params[:id]))
    if review.save
      render json: { message: "Review added successfully" }, status: :created
    else 
      render json: { message: "Failed to add Review" }
    end
  end

  def show_product_reviews
    @reviews = Review.where(product_detail_id: params[:id])
    render json: @reviews
  end

  private

  def review_params
    params.require(:review).permit(:rating, :review_message)
  end
end

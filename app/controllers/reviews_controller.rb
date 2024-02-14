class ReviewsController < ApplicationController
  
  def create
    review = Review.new(review_params.merge(user_id: current_user.id, product_detail_id: params[:id]))
    if review.save
      render json: { message: "Review added successfully", review: review }, status: :created
    else 
      render json: { message: "Failed to add Review" }, status: :bad_request
    end
  end

  def show_product_reviews
    @reviews = Review.where(product_detail_id: params[:id])
    if @reviews.empty?
      render json: "product not found for reviews", status: :bad_request
    else
      render json: @reviews, status: :ok
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :review_message)
  end
end

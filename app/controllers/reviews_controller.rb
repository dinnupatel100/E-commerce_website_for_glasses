class ReviewsController < ApplicationController
  load_and_authorize_resource :except => [:show_product_reviews]

  def create
    review = Review.new(review_params.merge(user_id: current_user.id, product_detail_id: params[:id]))
    if review.save
      render json: { message: I18n.t("review.reviewAddSuccess")}, status: :ok
    else 
      render json: { message: review.errors.full_messages }, status: :bad_request
    end
  end

  def show_product_reviews
    @reviews = Review.where(product_detail_id: params[:id])
    if @reviews.empty?
      render json: {message: I18n.t("review.reviewEmpty")}, status: :bad_request
    else
      render json: @reviews, status: :ok
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :review_message)
  end
end

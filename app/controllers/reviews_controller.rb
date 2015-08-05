class ReviewsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @review = @recipe.reviews.create(review_params)
    redirect_to recipe_path(@recipe)
  end

  private

  def review_params
    params.require(:review).permit(:body)

  end
end
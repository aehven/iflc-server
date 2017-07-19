class FavoritesController < ApplicationController

  def index
    @favorite = Favorite.where(user_id: current_user.id,
                               favoritable_type: params[:favoritable_type],
                               favoritable_id: params[:favoritable_id]).first

    if(@favorite)
      render json: @favorite and return
    else
      render json: {}, status: 404 and return
    end
  end

  def create
    @favorite = Favorite.new(favorite_params)
    @favorite.user_id = current_user.id

    if @favorite.save
      render json: @favorite
    else
      render json: @favorite.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    if @favorite.destroy
      render json: {}
    else
      render json: @favorite.errors, status: :unprocessable_entity
    end
  end

  private

  def favorite_params
    params.require(:favorite).require(:favoritable_type)
    params.require(:favorite).require(:favoritable_id)
    params.require(:favorite).permit(:favoritable_type, :favoritable_id)
  end
end

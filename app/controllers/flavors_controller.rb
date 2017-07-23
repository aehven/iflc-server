class FlavorsController < ApplicationController
  load_and_authorize_resource

  def index
    if !params[:search].blank?
      @flavors = @flavors.search(params[:search])
    end

    @flavors = @flavors.where("account_id = ?", params[:account_id]) if params[:account_id]

    @count = @flavors.count

    @flavors = @flavors.paginate(per_page: params[:per_page], page: params[:page])

    rows = (@flavors.map{|c| FlavorSerializer.new(c)}).map(&:attributes)

    render json: {flavors: rows, count: @count}
  end

  def show
    render json: @flavor
  end

  def update
    if @flavor.update_attributes(flavor_params)
      render json: @flavor
    else
      render json: @flavor.errors, status: :unprocessable_entity
    end
  end

  def create
    if @flavor.save
      render json: @flavor
    else
      render json: @flavor.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @flavor.destroy
      render json: {}
    else
      render json: @flavor.errors, status: :unprocessable_entity
    end
  end

  private

  def flavor_params
    params.require(:flavor).require(:name)
    params.require(:flavor).permit(:cee_id, :color)
  end

end

class CeesController < ApplicationController
  load_and_authorize_resource

  def index
    if params[:favorites_only] == "true"
      @cees = @cees.where(id: current_user.favorites.where(favoritable_type: "Cee").map(&:favoritable_id))
    end

    if !params[:search].blank?
      @cees = @cees.search(params[:search])
    end

    @count = @cees.count

    if(params[:export] == "true")
      xls = @cees.to_csv(col_sep: "\t")
      send_data xls, filename: "report.xls", type: 'application/xls', disposition: 'inline'
      # GenericMailer.email_report(current_user, xls).deliver_now
      # render json: {}, status: :accepted and return
    else
      @cees = @cees.paginate(per_page: params[:per_page], page: params[:page])
      rows = (@cees.map{|a| CeeSerializer.new(a)}).map(&:attributes)
      render json: {cees: rows, count: @count} and return
    end
  end

  def show
    render json: @cee
  end

  def update
    if @cee.update_attributes(cee_params)
      render json: @cee
    else
      render json: @cee.errors, status: :unprocessable_entity
    end
  end

  def create
    if @cee.save
      render json: @cee
    else
      render json: @cee.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @cee.destroy
      render json: {}
    else
      render json: @cee.errors, status: :unprocessable_entity
    end
  end

  private

  def cee_params
    params.require(:cee).require(:name)
    params.require(:cee).permit(:name, :form, :source)
  end

end

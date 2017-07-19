class AccountsController < ApplicationController
  load_and_authorize_resource

  def index
    if params[:favorites_only] == "true"
      @accounts = @accounts.where(id: current_user.favorites.where(favoritable_type: "Account").map(&:favoritable_id))
    end

    if !params[:search].blank?
      @accounts = @accounts.search(params[:search])
    end

    @count = @accounts.count

    if(params[:export] == "true")
      xls = @accounts.to_csv(col_sep: "\t")
      send_data xls, filename: "report.xls", type: 'application/xls', disposition: 'inline'
      # GenericMailer.email_report(current_user, xls).deliver_now
      # render json: {}, status: :accepted and return
    else
      @accounts = @accounts.paginate(per_page: params[:per_page], page: params[:page])
      rows = (@accounts.map{|a| AccountSerializer.new(a)}).map(&:attributes)
      render json: {accounts: rows, count: @count} and return
    end
  end

  def show
    render json: @account
  end

  def update
    if @account.update_attributes(account_params)
      render json: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  def create
    if @account.save
      render json: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @account.destroy
      render json: {}
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  private

  def account_params
    params.require(:account).require(:name)
    params.require(:account).permit(:name, :phone, :fax, :email, :website, :street, :city, :state, :zip, :kind, :om, :fd1, :fd2, :rc, :referrer)
  end

end

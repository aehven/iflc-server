class ContactsController < ApplicationController
  load_and_authorize_resource

  def index
    if !params[:search].blank?
      @contacts = @contacts.search(params[:search])
    end

    @contacts = @contacts.where("account_id = ?", params[:account_id]) if params[:account_id]

    @count = @contacts.count

    @contacts = @contacts.paginate(per_page: params[:per_page], page: params[:page])

    rows = (@contacts.map{|c| ContactSerializer.new(c)}).map(&:attributes)

    render json: {contacts: rows, count: @count}
  end

  def show
    render json: @contact
  end

  def update
    if @contact.update_attributes(contact_params)
      render json: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  def create
    if @contact.save
      render json: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @contact.destroy
      render json: {}
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact).require(:first_name)
    params.require(:contact).require(:last_name)
    params.require(:contact).permit(:account_id, :first_name, :last_name, :ma, :phone, :cellphone, :email, :street, :city, :state, :zip, :kind, :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday)
  end

end

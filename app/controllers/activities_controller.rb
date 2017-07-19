class ActivitiesController < ApplicationController
  load_and_authorize_resource

  def index
    if !params[:search].blank?
      @activities = @activities.search(params[:search])
    end

    @activities = @activities.where("account_id = ?", params[:account_id]) if params[:account_id]

    @count = @activities.count

    @activities = @activities.paginate(per_page: params[:per_page], page: params[:page]).to_a
    @activities.unshift(Activity.new(account_id: params[:account_id], date: DateTime.now))
    rows = (@activities.map{|a| ActivitySerializer.new(a)}).map(&:attributes)

    render json: {activities: rows, count: @count}
  end

  def show
    render json: @activity
  end

  def update
    if @activity.update_attributes(activity_params)
      render json: @activity
    else
      render json: @activity.errors, status: :unprocessable_entity
    end
  end

  def create
    if @activity.save
      render json: @activity
    else
      render json: @activity.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @activity.destroy
      render json: {}
    else
      render json: @activity.errors, status: :unprocessable_entity
    end
  end

  private

  def activity_params
    begin
      #convert the given date: {:year, :month, :day} to a date time
      #and assume the time is the current time
      params[:activity][:date] = DateTime.now
        .change(year: params[:activity][:date][:year],
                month: params[:activity][:date][:month],
                day: params[:activity][:date][:day])
    rescue
      params[:activity].delete("date")
    end

    params.require(:activity).require(:account_id)
    params.require(:activity).require(:date)
    params.require(:activity).require(:text)
    params.require(:activity).permit(:id, :account_id, :text, :date)
  end

end

class NotesController < ApplicationController
  load_and_authorize_resource

  def index
    if !params[:search].blank?
      @notes = @notes.search(params[:search])
    end

    @notes = @notes.where("cee_id = ?", params[:cee_id]) if params[:cee_id]

    @count = @notes.count

    @notes = @notes.paginate(per_page: params[:per_page], page: params[:page]).to_a
    @notes.unshift(Note.new(cee_id: params[:cee_id], date: DateTime.now))
    rows = (@notes.map{|a| NoteSerializer.new(a)}).map(&:attributes)

    render json: {notes: rows, count: @count}
  end

  def show
    render json: @note
  end

  def update
    if @note.update_attributes(note_params)
      render json: @note
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  def create
    if @note.save
      render json: @note
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @note.destroy
      render json: {}
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  private

  def note_params
    begin
      #convert the given date: {:year, :month, :day} to a date time
      #and assume the time is the current time
      params[:note][:date] = DateTime.now
        .change(year: params[:note][:date][:year],
                month: params[:note][:date][:month],
                day: params[:note][:date][:day])
    rescue
      params[:note].delete("date")
    end

    params.require(:note).require(:cee_id)
    params.require(:note).require(:date)
    params.require(:note).require(:text)
    params.require(:note).permit(:id, :cee_id, :text, :date)
  end

end

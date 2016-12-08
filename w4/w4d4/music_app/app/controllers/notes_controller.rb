class NotesController < ApplicationController
  before_action :must_login

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    flash[:messages] = @note.errors.full_messages unless @note.save
    redirect_to track_url(@note.track_id)
  end

  def destroy
    @note = Note.find(params[:id])
    if @note.user_id != current_user.id
      flash[:messages] = ["ONLY EDIT YOUR OWN NOTES"]
    else
      @note.destroy
      redirect_to track_url(@note.track_id)
    end
  end

  private

  def note_params
    params.require(:note).permit(:track_id, :content)
  end
end

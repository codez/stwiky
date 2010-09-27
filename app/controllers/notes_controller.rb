class NotesController < ApplicationController

  def index
    @notes = Note.all
  end
  
  def create
    @note = Note.new params[:note]
    @note.user = @current_user
    @note.save
  end

  def update
    @note = Note.find(params[:id])
    @note.update_attributes(params[:note].merge({:updated_at => Time.now}))
  end

  def pos
    @note = Note.find(params[:id])
    @note.update_attributes(params[:note])
  end
  
  def destroy
    @note = Note.find(params[:id])
    @note.destroy
  end
  
end
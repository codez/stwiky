class NotesController < ApplicationController

  before_filter :set_note, :only => ['show', 'edit', 'update', 'pos', 'destroy']

  def index
    @notes = @current_user.boards.first.notes
  end
  
  def show    
  end

  def new
    @note = Note.new params[:note]
  end
  
  def create
    @note = Note.new params[:note]
    @note.board = @current_user.boards.first
    @note.save
  end
  
  def edit
  end

  def update
    @note.update_attributes(params[:note].merge({:updated_at => Time.now}))
  end

  def pos
    @note.update_attributes(params[:note])
  end
  
  def destroy
    @note.destroy
  end
  
  private
  
  def set_note
    @note = Note.find(params[:id])    
  end
  
end
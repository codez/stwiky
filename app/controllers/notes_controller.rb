class NotesController < ApplicationController

  respond_to :html, :xml, :only => [:index]
  respond_to :js, :xml, :except => [:index]

  before_filter :set_note, :only => ['show', 'edit', 'update', 'pos', 'destroy']

  def index
    @notes = @current_user.boards.first.notes
    respond_with(@notes)
  end
  
  def show    
    respond_with(@note)
  end

  def new
    @note = Note.new params[:note]
    respond_with(@note)
  end
  
  def create
    @note = Note.new params[:note]
    @note.board = @current_user.boards.first
    if @note.save
      respond_with(@note)
    else
      render :action => 'errors'
    end
  end
  
  def edit
    respond_with(@note)
  end

  def update
    attrs = params[:note]
    attrs.merge({:updated_at => Time.now}) unless params[:silent]
    if @note.update_attributes(attrs)
      respond_with(@note)
    else
      render :action => 'errors'      
    end
  end
  
  def destroy
    @note.destroy
    respond_with(@note)
  end
  
  private
  
  def set_note
    @note = Note.find(params[:id])    
  end
  
end
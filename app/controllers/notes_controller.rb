class NotesController < ApplicationController

  respond_to :html, :xml, :only => [:index]
  respond_to :js, :xml, :except => [:index]

  before_filter :set_note, :only => ['show', 'edit', 'update', 'pos', 'destroy', 'syntax']

  def index
    @notes = current_notes
    respond_with(@notes)
  end
  
  def syntax
    @syntax = Note.new :pos_x => @note.pos_right, 
                       :pos_y => @note.pos_y,
                       :width => 100,
                       :height => 300                    
  end
  
  def show    
    respond_with(@note)
  end

  def new
    @note = Note.new params[:note]
    @note.pos_y ||= max_y
    @note.use_defaults_where_blank
    respond_with(@note)
  end
  
  def create
    @note = Note.new params[:note]
    if @note.save
      respond_with(@note)
    else
      render :partial => 'shared/errors', :object => @note  
    end
  end
  
  def edit
    respond_with(@note)
  end

  def update
    params[:note][:updated_at] = Time.now unless params[:silent]
    if @note.update_attributes(params[:note])
      respond_with(@note)
    else
      render :partial => 'shared/errors', :object => @note     
    end
  end
  
  def destroy
    @note.destroy
    respond_with(@note)
  end
  
  protected
  
  def default_url_options
    {:username => @current_user.try(:name), 
     :boardname => @board.try(:name) }
  end
  
  private
  
  def current_notes
    current_board.notes
  end
  
  def current_board
    if params[:boardname]
      @board = Board.find_by_shortname params[:boardname]
    end
    @board ||= @current_user.boards.first
  end
  
  def set_note
    @note = Note.find(params[:id])    
  end
  
  def max_y
    current_notes.collect(&:pos_bottom).max.to_i
  end
  
end
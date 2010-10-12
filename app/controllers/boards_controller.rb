class BoardsController < ApplicationController
  
  respond_to :html, :xml, :only => [:index]
  respond_to :js, :xml, :except => [:index]
  
  before_filter :set_board, :only => ['edit', 'update', 'destroy']
  
  def index
    redirect_to root_path
  end
  
  def new
    @board = Board.new
  end
  
  def create
    @board = Board.new params[:board]
    @board.user = @current_user
    if @board.save
      respond_with(@board)
    else
      render :partial => 'shared/errors', :object => @board  
    end
  end
 
  def edit
    respond_with(@board)
  end
  
  def update
    if @board.update_attributes(params[:board])
      respond_with(@board)
    else
      render :partial => 'shared/errors', :object => @board   
    end
  end
  
  def destroy
    @board.destroy
    respond_with(@board)
  end
  
  def order
    position = 0
    params['boards'].each do |id|
      Board.find(id).update_attribute :position, position
      position += 1
    end
    render :status => 200
  end
  
  protected
  
  def default_url_options
    {:username => @current_user.try(:name)}
  end
  
  private
  
  def set_board
    @board = Board.find(params[:id])
  end
  
end
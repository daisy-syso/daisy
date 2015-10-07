class EditorsController < ApplicationController
  before_action :check_auth
  before_action :set_editor, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    email = session[:editor]
    editor = Editor.find_by(email: email)
    if editor.role == 'admin'
      @editors = Editor.all.page(params[:page]).per(params[:per])
      respond_with(@editors)
    else
      redirect_to drugs_drugs_path
    end
  end

  def show
    respond_with(@editor)
  end

  def new
    @editor = Editor.new
    respond_with(@editor)
  end

  def edit
  end

  def create
    @editor = Editor.new(editor_params)
    
    if @editor.save
      flash[:notice] = 'Editor was successfully created.' 
      @editor.add_role :store_owner
    end
    respond_with(@editor)
  end

  def update
    flash[:notice] = 'Editor was successfully updated.' if @editor.update(editor_params)
    respond_with(@editor)
  end

  def destroy
    @editor.destroy
    respond_with(@editor)
  end

  private
    def set_editor
      @editor = Editor.find(params[:id])
    end

    def editor_params
      params.require(:editor).permit(:email, :username, :telephone, :password)
    end
end

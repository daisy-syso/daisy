class EditorsController < ApplicationController
  before_action :set_editor, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @editors = Editor.all
    respond_with(@editors)
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
    flash[:notice] = 'Editor was successfully created.' if @editor.save
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
      params.require(:editor).permit(:email, :username, :telephone, :password_hash)
    end
end

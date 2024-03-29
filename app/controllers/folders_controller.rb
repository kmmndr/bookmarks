class FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate

  # GET /folders/browse/:path
  def browse
    path = params[:path]
    @current_folder = Folder.by_user(current_user).create_hierarchy(path.try(:split,File::SEPARATOR))
    authorize_action_for @current_folder

    arbo = []
    @current_folder.ancestors.each do |level|
      arbo << level
      add_menu level, browse_folders_path(arbo.join(File::SEPARATOR))
    end

    @folders = Folder.by_user(current_user).with_parent(@current_folder).ordered_by_name
    @bookmarks = @current_folder.try(:bookmarks).try(:ordered_by_title) || []

    respond_to do |format|
      format.js
      format.html { render action: 'index' }
    end
  end
  authority_actions :browse => 'read'


  # GET /folders
  # GET /folders.json
  def index
    parent = params[:parent]
    if parent.nil?
      @current_folder = Folder.by_user(current_user).with_parent(nil).first
    else
      @current_folder = Folder.by_user(current_user).find(parent)
    end

    authorize_action_for @current_folder unless @current_folder.nil?

    respond_to do |format|
      format.html
    end
  end

  # GET /folders/1
  # GET /folders/1.json
  def show
  end

  # GET /folders/new
  def new
    @folder = Folder.new
  end

  # GET /folders/1/edit
  def edit
  end

  # POST /folders
  # POST /folders.json
  def create
    @folder = Folder.new(folder_params)

    respond_to do |format|
      if @folder.save
        format.html { redirect_to @folder, notice: 'Folder was successfully created.' }
        format.json { render action: 'show', status: :created, location: @folder }
      else
        format.html { render action: 'new' }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /folders/1
  # PATCH/PUT /folders/1.json
  def update
    respond_to do |format|
      if @folder.update(folder_params)
        format.html { redirect_to @folder, notice: 'Folder was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /folders/1
  # DELETE /folders/1.json
  def destroy
    @folder.destroy
    respond_to do |format|
      format.html { redirect_to folders_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_folder
      @folder = Folder.find(params[:id])
      authorize_action_for @folder
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def folder_params
      params.require(:folder).permit(:name)
    end
end

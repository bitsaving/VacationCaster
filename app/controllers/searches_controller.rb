class SearchesController < ApplicationController
  before_action :set_search, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:create]
  # GET /searches
  # GET /searches.json
  def index
    @searches = Search.where(user_id: current_user.id)
    redirect_to new_search_path if @searches.empty?
  end

  # GET /searches/1
  # GET /searches/1.json
  def show
    redirect_to "/" if current_user!=@search.user
    redirect_to "/"
  end

  # GET /searches/new
  def new
    @search = Search.new
    @search.options = params[:options]
  end

  # GET /searches/1/edit
  def edit
    redirect_to "/"
  end

  # POST /searches
  # POST /searches.json
  def create
    @search = Search.new(search_params.slice!("email"))
    email = search_params.delete "email"
    if current_user.nil?
      if !User.find_by_email(email).nil?
        redirect_to :back, :flash => { :error => "User already exists" }
      end
      sign_in(:user, User.create(email: email, password: "password"))
    end
    @search.user = current_user

    respond_to do |format|
      if @search.save
        format.html { redirect_to searches_path, notice: 'Search was successfully created.' }
        format.json { render :show, status: :created, location: @search }
      else
        format.html { render :new }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /searches/1
  # PATCH/PUT /searches/1.json
  def update
    redirect_to "/" if current_user!=@search.user
    respond_to do |format|
      if @search.update(search_params)
        format.html { redirect_to @search, notice: 'Search was successfully updated.' }
        format.json { render :show, status: :ok, location: @search }
      else
        format.html { render :edit }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /searches/1
  # DELETE /searches/1.json
  def destroy
    redirect_to "/" if current_user!=@search.user
    @search.destroy
    respond_to do |format|
      format.html { redirect_to searches_url, notice: 'Search was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search
      @search = Search.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.require(:search).permit(:options, :name, :slug, :start_date, :end_date, :user_id, :email)
    end
end

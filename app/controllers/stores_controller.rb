class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy]


  def search
    @store = Store.new
    render :search
  end

  def find_store    
    @store_coordinates = Geocoder.coordinates(store_params["formatted_address"])
    @min_dist_store_id = Store.find_closest_store(@store_coordinates)   
    if Store.find(@min_dist_store_id)
      render :json => { 
           :status => :ok, 
           :message => "Success!",
           :data => Store.find(@min_dist_store_id),
           :html => "<b>congrats</b>"
        }.to_json
    else
      render :json => { 
           :status => :error, 
           :message => "Address not found",
           :data => nil,
           :html => "<b>didn't work</b>"
        }.to_json
    end
  end

  # GET /stores
  # GET /stores.json
  def index
    @stores = Store.all
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
  end

  # GET /stores/new
  def new
    @store = Store.new
  end

  # GET /stores/1/edit
  def edit
  end

  # POST /stores
  # POST /stores.json
  def create
    @store = Store.new(store_params)

    respond_to do |format|
      if @store.save
        format.html { redirect_to @store, notice: 'Store was successfully created.' }
        format.json { render :show, status: :created, location: @store }
      else
        format.html { render :new }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stores/1
  # PATCH/PUT /stores/1.json
  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to @store, notice: 'Store was successfully updated.' }
        format.json { render :show, status: :ok, location: @store }
      else
        format.html { render :edit }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    @store.destroy
    respond_to do |format|
      format.html { redirect_to stores_url, notice: 'Store was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit(:store_name, :location, :address, :city, :state, :zip_code, :latitude, :longitude, :county, :formatted_address)
    end
end

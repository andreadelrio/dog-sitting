  class ProvidersController < ApplicationController
  before_action :set_provider, only: [:show, :edit, :update]
  before_action :require_current_provider, only: [:edit]
  before_action :require_unlogged_provider, only: [:new]
  before_action :get_dates, only: [:index]


  # GET /providers
  # GET /providers.json
  def index
    @search = Provider.search(params[:q])
    @providers = @search.result.order("last_name_1 DESC")
  end

  def home
    @search = Provider.search(params[:q])
    @referral = Referral.new
    @referrals = Referral.all
  end  

  # GET /providers/1
  # GET /providers/1.json
  def show
    @provider_attachments = @provider.provider_attachments.all
  end

  # GET /providers/new
  def new
    @provider = Provider.new
    @provider_attachment = @provider.provider_attachments.build
  end

  # GET /providers/1/edit
  def edit
    @provider_attachment = @provider.provider_attachments.build
    @new_provider_attachment = @provider.provider_attachments.new
  end

  # POST /providers
  # POST /providers.json
  def create
    @provider = Provider.new(provider_params)
      if @provider.save
        session[:provider_id] = @provider.id
        unless params[:provider_attachments].nil?
          params[:provider_attachments]['photo'].each do |a|
             @provider_attachment = @provider.provider_attachments.create!(:photo => a, :provider_id => @provider.id)
          end
        end
        flash.now[:success] = "Hola #{@provider.name}, bienvenido a Kmimos."
        redirect_to root_path
      else
       render "new"
      end
  end

  # PATCH/PUT /providers/1
  def update
    respond_to do |format|
      if @provider.update(provider_params)
        unless params[:provider_attachments].nil?
          params[:provider_attachments]['photo'].each do |a|
             @provider_attachment = @provider.provider_attachments.create!(:photo => a, :provider_id => @provider.id)
          end
        end
        format.html { redirect_to root_path }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_provider
      @provider = Provider.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def provider_params
      params.require(:provider).permit(:tipo_propiedad, :areas_externas, :emergencia, :experiencia, :iframe_code, :name, :last_name_1, :last_name_2, :dni, :avatar, :avatar_cache, :description, :email, :email_c, :phone, :price, :avg_rating, :property_id, :password, :password_confirmation, locations_attributes: [:id], location_ids: [], provider_attachments_attributes: [:id, :provider_id, :photo], age_ids: [], size_ids: [])
    end

    def get_dates
      unless params[:start_date].nil? || params[:start_date].empty?
        session[:start_date] = Date.strptime(params[:start_date],'%d/%m/%Y')
      end
      unless params[:end_date].nil? || params[:end_date].empty?
        session[:end_date] = Date.strptime(params[:end_date],'%d/%m/%Y')
      end
    end
end

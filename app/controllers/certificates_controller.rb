class CertificatesController < ApplicationController
  before_action :set_certificate, only: [:show, :update, :destroy]

  # GET /owners/:owner_id/certificates
  def index
    begin
      @owner = Owner.find(params[:owner_id])
      @certificates = Certificate.where(owner_id: params[:owner_id])
      render json: @certificates
    rescue ActiveRecord::RecordNotFound
      render :head => true, :status => :not_found
    end
  end

  # GET /owners/:owner_id/certificates/:id
  def show
    if @certificate.nil?
      render :head => true, :status => :not_found
    else
      render json: @certificate
    end
  end

  # POST /owners/:owner_id/certificates
  def create
    @certificate = Certificate.new(certificate_params)

    if @certificate.save
      helpers.register_certificate(@certificate)
      render json: @certificate, status: :created, location: @certificate
    else
      render json: @certificate.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /owners/:owner_id/certificates/:id
  def update
    if @certificate.update(certificate_params)
      render json: @certificate
    else
      render json: @certificate.errors, status: :unprocessable_entity
    end
  end

  # DELETE /owners/:owner_id/certificates/:id
  def destroy
    @certificate.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_certificate
      begin
        @certificate = Certificate.where(owner_id: params[:owner_id]).where(id: params[:id]).first!
      rescue ActiveRecord::RecordNotFound
        @certificate = nil
      end
    end

    # Only allow a trusted parameter "white list" through.
    def certificate_params
      params.require(:certificate).permit(:cn, :last_crt, :csr, :key, :detail, :acme_id, :owner_id)
    end
end

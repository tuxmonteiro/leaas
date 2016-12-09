class CertificateController < ApplicationController

  def index
    @certificates = Certificate.all
  end

  def show
    @certificate = Certificate.find(params[:id])
  end

  def new
    @certificate = Certificate.new
  end

end

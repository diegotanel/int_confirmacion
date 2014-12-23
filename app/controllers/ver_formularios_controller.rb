#encoding: utf-8
class VerFormulariosController < ApplicationController
  before_action :signed_in_user, only: [:index]
  before_action :admin_user, only: [:index]

  def index
    @q = Formulario.where(estado: 1).search(params[:q])
    @formularios = @q.result.includes(:formularios, :principals, :provincias, :regiones, :datos_grupos, :datos_esps, :elencos_en_gira, :integrantes_de_elenco_en_gira)
  end

  private

  def admin_user
    redirect_to(root_url) unless current_user.admin? or current_user.jurado?
  end
end

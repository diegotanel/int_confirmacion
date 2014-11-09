#encoding: utf-8
class VerFormulariosController < ApplicationController
  before_action :signed_in_user, only: [:index]
  before_action :admin_user, only: [:index]

  def index
    @q = Formulario.where(estado: 1).search(params[:q])
    @formularios = @q.result.includes(:formularios, :principals, :provincias, :regiones)
  end

  private

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end

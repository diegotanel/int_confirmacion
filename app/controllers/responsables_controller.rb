class ResponsablesController < ApplicationController
  before_action :signed_in_user, only: [:new, :show]

	def new
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @responsable = Responsable.new
  end

  def show
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @responsable = Responsable.find(params[:id])
  end
end
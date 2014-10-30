class ResponsablesController < ApplicationController
  before_action :signed_in_user, only: [:show, :edit, :update, :index]

  def show
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @responsable = Responsable.find(params[:id])
  end

  def index
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @formulario.create_responsable() unless @formulario.responsable
    @fisica_existente = @formulario.responsable.persona_fisica_e
    @fisica_nueva = @formulario.responsable.persona_fisica_n
    @juridica = @formulario.responsable.persona_juridica
    flash[:success] = "Datos del responsable creados"
  end

  def edit
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @responsable = Responsable.find(params[:id])
  end

  def update
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @responsable = Responsable.find(params[:id])
    if @responsable.update_attributes(responsable_params)
      flash[:success] = "Datos del responsable actualizados"
      redirect_to formulario_responsable_path(@formulario, @responsable)
    else
      render 'edit'
    end
  end
end
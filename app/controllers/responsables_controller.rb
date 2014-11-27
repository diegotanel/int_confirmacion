class ResponsablesController < ApplicationController
  before_action :signed_in_user, only: [:show, :edit, :update, :index, :destroy]

  def show
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @responsable = @formulario.responsable
    if (@responsable.persona_fisica_e) && (@formulario.elenco_en_gira)
      #@numero_de_id = @formulario.responsable.persona_fisica_e.integrante_de_elenco_en_gira_id
      @integrante = @formulario.elenco_en_gira.integrantes_de_elenco_en_gira.where(params[:id])
    end
  end

  def index
    @formulario = Formulario.find_by_id(params[:formulario_id])
    #@formulario.create_responsable() unless @formulario.responsable
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

  def destroy
    @formulario = Formulario.find_by_id(params[:formulario_id])
    if @formulario.responsable.destroy
      flash[:success] = "Se ha eliminado el responsable"
      redirect_to edit_formulario_path(@formulario)
    else
      flash.now[:failure] = "El responsable no pudo ser eliminado"
      redirect_to edit_formulario_path(@formulario)
    end
  end

  def errores
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @responsable = Responsable.find(params[:id])
  end
end
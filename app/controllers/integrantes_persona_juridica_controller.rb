#encoding: utf-8
class IntegrantesPersonaJuridicaController < ApplicationController
  before_action :signed_in_user, only: [:show, :new, :edit, :create, :update, :destroy]
  before_action :inicializar_variables, only: [:new, :edit]

  def show
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @integrante = IntegrantePersonaJuridica.find(params[:id])
  end

  def new
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @integrante = IntegrantePersonaJuridica.new(params[:id])
  end

  def edit
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @integrante = IntegrantePersonaJuridica.find(params[:id])
  end

  def create
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @integrante = IntegrantePersonaJuridica.new(integrante_persona_juridica_params)
    if @formulario.persona_juridica.integrantes_persona_juridica << @integrante
      flash[:success] = "Se ha creado un integrante correctamente"
      redirect_to formulario_persona_juridica_path
    else
      inicializar_variables
      render 'new'
    end
  end

  def update
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @integrante = IntegrantePersonaJuridica.find(params[:id])
    if @integrante.update(integrante_persona_juridica_params)
      flash[:success] = "Se ha actualizado un integrante correctamente"
      redirect_to formulario_persona_juridica_path
    else
      inicializar_variables
      render 'edit'
    end
  end

  def destroy
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @formulario.persona_juridica.integrantes_persona_juridica.destroy(params[:id])
    if @formulario.persona_juridica.save
      flash[:success] = "Se ha eliminado el integrante correctamente"
      redirect_to formulario_persona_juridica_path
    else
      flash.now[:failure] = "El integrante no pudo ser eliminado"
      render 'index'
    end
  end

  private

  def integrante_persona_juridica_params
    params.require(:integrante_persona_juridica).permit(:provincia_id, :localidad_id, :cargo, :nombre, :apellido, :cuil_cuit, "fecha_de_nacimiento(3i)", "fecha_de_nacimiento(2i)", "fecha_de_nacimiento(1i)", :calle, :altura_calle, :piso, :depto, :codigo_postal, :tel_particular, :tel_celular, :email)
  end

  def inicializar_variables
    @provincias = Provincia.all
    @region = Region.all
    @localidades = Localidad.all
  end
end
#encoding: utf-8
class IntegrantesDeElencoEnGiraController < ApplicationController
  before_action :signed_in_user, only: [:show, :new, :edit, :create, :update, :destroy]
  before_action :inicializar_variables, only: [:new, :edit]
  before_action :set_type

  def show
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @integrante = IntegranteDeElencoEnGira.find(params[:id])
  end

  def new
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @integrante = IntegranteDeElencoEnGira.new(type: params[:type])
  end

  def edit
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @integrante = IntegranteDeElencoEnGira.find(params[:id])
  end

  def create
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @integrante = IntegranteDeElencoEnGira.new(integrante_de_elenco_en_gira_params)
    unless @formulario.elenco_en_gira
      @elenco = @formulario.build_elenco_en_gira
      @elenco.saltear_validaciones_de_presencia = true
      @elenco.save!
    end
    @integrante.saltear_validaciones_de_presencia = true
    if @formulario.elenco_en_gira.integrantes_de_elenco_en_gira << @integrante
      flash[:success] = "Se ha creado un integrante correctamente"
      redirect_to formulario_elencos_en_gira_path
    else
      set_type
      inicializar_variables
      render 'new'
    end
  end

  def update
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @integrante = IntegranteDeElencoEnGira.find(params[:id])
    @formulario.elenco_en_gira.saltear_validaciones_de_presencia = true
    @integrante.saltear_validaciones_de_presencia = true
    if @integrante.update(integrante_de_elenco_en_gira_params)
      flash[:success] = "Se ha actualizado un integrante correctamente"
      redirect_to formulario_elencos_en_gira_path
    else
      set_type
      inicializar_variables
      render 'edit'
    end
  end

  def destroy
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @formulario.elenco_en_gira.saltear_validaciones_de_presencia = true
    if @formulario.elenco_en_gira.integrantes_de_elenco_en_gira.destroy(params[:id])
      flash[:success] = "Se ha eliminado el integrante correctamente"
      redirect_to formulario_elencos_en_gira_path
    else
      flash.now[:failure] = "El integrante no pudo ser eliminado"
      render 'index'
    end
  end

  private

  def integrante_de_elenco_en_gira_params
    params.require(@type.underscore.to_sym).permit(:type, :provincia_id, :localidad_id, :nombre, :apellido, :cuil_cuit, "fecha_de_nacimiento(3i)", "fecha_de_nacimiento(2i)", "fecha_de_nacimiento(1i)", :fecha_de_nacimiento,:calle, :altura_calle, :piso, :depto, :codigo_postal, :tel_particular, :tel_celular, :email)
  end

  def inicializar_variables
    @provincias = Provincia.all
    @region = Region.all
    @localidades = Localidad.all
  end

  def set_type
    @type = params[:type]
  end

end

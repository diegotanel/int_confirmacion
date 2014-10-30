class PersonasFisicasEController < ApplicationController
  before_action :signed_in_user, only: [:new, :show, :create, :edit, :update]
  before_action :inicializar_variables, only: [:new, :create, :buscar_integrante_por_cuil_cuit]

  def new
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @persona_fisica_e = PersonaFisicaE.new
  end

  def buscar_integrante_por_cuil_cuit
  	@buscado = IntegranteDeElencoEnGira.find_by_cuil_cuit(params[:numero_cuil_cuit])
    @formulario.responsable.persona_fisica_e = @buscado
  end
  
  def create
  	@formulario = Formulario.find_by_id(params[:formulario_id])
  	@formulario.responsable.persona_fisica_e = @buscado
  end

  private

  def inicializar_variables
    @integrantes = IntegranteDeElencoEnGira.all
  end
end
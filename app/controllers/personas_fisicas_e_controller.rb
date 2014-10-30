class PersonasFisicasEController < ApplicationController
  before_action :signed_in_user, only: [:new, :show, :create, :edit, :update]
  before_action :inicializar_variables, only: [:new, :create, :buscar_integrante_por_cuil_cuit]

  def new
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @persona_fisica_e = PersonaFisicaE.new
  end

  def buscar_integrante_por_cuil_cuit
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @responsable = Formulario.responsable
  	@buscado = IntegranteDeElencoEnGira.find_by_cuil_cuit(params[:numero_cuil_cuit])
    if @buscado.save
      @formulario.responsable.build_persona_fisica_e()
    else
      flash[:error] = "No se encontro a ninguna persona con ese cuil o cuit"
    end
  end
  
  def create
  	@formulario = Formulario.find_by_id(params[:formulario_id])
  	@buscado = @formulario.responsable.build_persona_fisica_e()
  end

  private

  def inicializar_variables
    @integrantes = IntegranteDeElencoEnGira.all
  end
end
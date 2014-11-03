class PersonasFisicasEController < ApplicationController
  before_action :signed_in_user, only: [:new, :show, :create, :edit, :update, :index]
  before_action :inicializar_variables, only: [:new, :create, :buscar_integrante_por_cuil_cuit]

  def new
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @persona_fisica_e = PersonaFisicaE.new
  end

  def buscar_integrante_por_cuil_cuit
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @buscado = nil
    if @formulario.elenco_en_gira
      @buscado = @formulario.elenco_en_gira.integrantes_de_elenco_en_gira.where(cuil_cuit: params[:numero_cuil_cuit])[0]
    end
    if @buscado.nil?
      flash[:error] = "No se encontro a ninguna persona con ese cuil o cuit"
      render 'new'
    else
      if @buscado.es_menor?
        flash[:error] = "No es posible seleccionar el integrante por ser menor"
        render 'new'
      else
        flash[:success] = "Se encontro a un integrante con ese cuil/cuit"
        redirect_to formulario_persona_fisica_e_path(@formulario, @buscado)
      end
    end
  end

  def show
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @buscado = @formulario.elenco_en_gira.integrantes_de_elenco_en_gira.where(id: params[:id])[0]
  end

  def create
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @buscado = @formulario.elenco_en_gira.integrantes_de_elenco_en_gira.where(id: params[:id])[0]
    if @formulario.responsable.persona_fisica_e
      @formulario.responsable.persona_fisica_e.destroy
    end
    @persona_fisica_e = @formulario.responsable.build_persona_fisica_e(integrante_de_elenco_en_gira_id: @buscado.id)
    @responsable = @formulario.responsable
    if @persona_fisica_e.save!
      flash[:success] = "Datos de la persona fisica correctamente creados"
      redirect_to vista_formulario_persona_fisica_e_path(@formulario, @persona_fisica_e)
    else
      flash[:error] = "Hubo un problema, intentelo nuevamente"
      redirect_to new_formulario_persona_fisica_e_path(@formulario)
    end
  end

  def index
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @buscado = IntegranteDeElencoEnGira.where(id: params[:id])[0]
    @persona_fisica_e = @formulario.responsable.build_persona_fisica_e()
    if @persona_fisica_e.save!
      flash[:success] = "Datos de la persona fisica correctamente creados"
      redirect_to formulario_responsable_path(@formulario, @responsable)
    else
      flash[:error] = "Hubo un problema, intentelo nuevamente"
      redirect_to new_formulario_persona_fisica_e_path(@formulario)
    end
  end

  def vista
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @persona_fisica_e = @formulario.responsable.persona_fisica_e
    @integrante = @formulario.elenco_en_gira.integrantes_de_elenco_en_gira.where(id: @persona_fisica_e.integrante_de_elenco_en_gira_id)[0]
  end

  private

  def inicializar_variables
    @integrantes = IntegranteDeElencoEnGira.all
  end
end

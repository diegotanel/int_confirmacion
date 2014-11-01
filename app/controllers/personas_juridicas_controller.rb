class PersonasJuridicasController < ApplicationController
  before_action :inicializar_variables, only: [:new, :edit]
  before_action :signed_in_user, only: [:new, :show, :create, :edit, :update]

  def new
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @persona_juridica = PersonaJuridica.new
  end

  def show
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @persona_juridica = PersonaJuridica.find(params[:id])
  end

  def create
  	@formulario = Formulario.find_by_id(params[:formulario_id])
  	if @formulario.responsable.persona_juridica
      @formulario.responsable.persona_juridica.destroy
    end

    @persona_juridica = @formulario.responsable.build_persona_juridica(persona_juridica_params)
    if @persona_juridica.save
      flash[:success] = "Datos de la persona juridica correctamente creados"
      redirect_to formulario_integrantes_comision_directiva_path
    else
      inicializar_variables
      render 'new'
    end
  end

  def edit
  	@formulario = Formulario.find_by_id(params[:formulario_id])
    @persona_juridica = PersonaJuridica.find(params[:id])
  end

  def update
  	@formulario = Formulario.find_by_id(params[:formulario_id])
    @persona_juridica = PersonaJuridica.find(params[:id])
    if @persona_juridica.update_attributes(persona_juridica_params)
      flash[:success] = "Datos de la persona juridica actualizados"
      redirect_to formulario_integrantes_comision_directiva_path
    else
      render 'edit'
    end
  end

  private

	def persona_juridica_params
	  params.require(:persona_juridica).permit(:nombre_per_juridica, :num_cuit, :num_per_juridica, :calle, 
       :altura_calle, :localidad_id, :codigo_postal, :email_entidad, :tel_entidad)
	end

  def inicializar_variables
    @provincias = Provincia.all
    @region = Region.all
    @localidades = Localidad.all
  end
end
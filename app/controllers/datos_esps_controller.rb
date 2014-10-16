class DatosEspsController < ApplicationController
  before_action :inicializar_variables, only: [:new, :edit]
  before_action :signed_in_user, only: [:new, :show, :create, :edit, :update]

	def new
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @datos_esp = DatosEsps.new
  end

  def show
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @datos_esp = DatosEsps.find(params[:id])
  end

  def create
  	@formulario = Formulario.find_by_id(params[:formulario_id])
  	@datos_esp = @formulario.build_datos_esp(datos_esp_params)
    if @datos_esp.save
      flash[:success] = "Datos del espectaculo correctamente creados"
      redirect_to formulario_datos_esp_path(@formulario, @datos_esp)
    else
      inicializar_variables
      render 'new'
    end
  end

  def edit
  	@formulario = Formulario.find_by_id(params[:formulario_id])
    @datos_esp = DatosEsps.find(params[:id])
  end

  def update
  	@formulario = Formulario.find_by_id(params[:formulario_id])
    @datos_esp = DatosEsps.find(params[:id])
    if @datos_esp.update_attributes(datos_esp_params)
      flash[:success] = "Datos del espectaculo actualizados"
      redirect_to formulario_datos_esp_path(@formulario, @datos_esp)
    else
      render 'edit'
    end
  end

  private

	  def datos_esp_params
	    params.require(:datos_esp).permit(:interpretes_escena, :directores_espectaculo, :fecha_de_estreno, :nombre_autor, 
        :nacionalidad_autor, :duracion_espectaculo, :sinopsis_obra, :gen_esp_ids => [], :publ_edad_ids => [], :publ_exp_ids => [], :formato_ids => [])
	  end

    def inicializar_variables
      @gen_esp = GenEsps.all
      @publ_exp = PublsExp.all
      @publ_edad = PublsEdad.all
      @formato = Formatos.all
    end
end
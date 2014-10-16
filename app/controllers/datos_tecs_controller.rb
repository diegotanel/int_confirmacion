class DatosTecsController < ApplicationController
  before_action :inicializar_variables, only: [:new, :edit]
  before_action :signed_in_user, only: [:new, :show, :create, :edit, :update]

	def new
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @datos_tec = DatosTecs.new
  end

  def show
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @datos_tec = DatosTecs.find(params[:id])
  end

  def create
  	@formulario = Formulario.find_by_id(params[:formulario_id])
  	@datos_tec = @formulario.build_datos_tec(datos_tec_params)
    if @datos_tec.save
      flash[:success] = "Datos tecnicos del espectaculo correctamente creados"
      redirect_to formulario_datos_tec_path(@formulario, @datos_tec)
    else
      inicializar_variables
      render 'new'
    end
  end

  def edit
  	@formulario = Formulario.find_by_id(params[:formulario_id])
    @datos_tec = DatosTecs.find(params[:id])
  end

  def update
  	@formulario = Formulario.find_by_id(params[:formulario_id])
    @datos_tec = DatosTecs.find(params[:id])
    if @datos_tec.update_attributes(datos_tec_params)
      flash[:success] = "Datos tecnicos del espectaculo actualizados"
      redirect_to formulario_datos_tec_path(@formulario, @datos_tec)
    else
      render 'edit'
    end
  end

  private

	  def datos_tec_params
	    params.require(:datos_tec).permit(:esps_esp_ids => [], :historia)
	  end

    def inicializar_variables
      @esps_esp = EspsEsps.all
    end
end
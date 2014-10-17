class DatosEspsController < ApplicationController
  before_action :inicializar_variables, only: [:new, :edit]
  before_action :signed_in_user, only: [:new, :show, :create, :edit, :update]

	def new
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @datos_responsable = DatosDelResponsable.new
  end

  def show
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @datos_responsable = DatosDelResponsable.find(params[:id])
  end

  def create
  	@formulario = Formulario.find_by_id(params[:formulario_id])
  	@datos_responsable = @formulario.build_datos_del_responsable(datos_del_responsable_params)
    if @datos_responsable.save
      flash[:success] = "Datos del responsable correctamente creados"
      redirect_to formulario_datos_del_responsable_path(@formulario, @datos_responsable)
    else
      inicializar_variables
      render 'new'
    end
  end

  def edit
  	@formulario = Formulario.find_by_id(params[:formulario_id])
    @datos_responsable = DatosDelResponsable.find(params[:id])
  end

  def update
  	@formulario = Formulario.find_by_id(params[:formulario_id])
    @datos_responsable = DatosDelResponsable.find(params[:id])
    if @datos_responsable.update_attributes(datos_del_responsable_params)
      flash[:success] = "Datos del responsable actualizados"
      redirect_to formulario_datos_esp_path(@formulario, @datos_responsable)
    else
      render 'edit'
    end
  end

  private

	 def datos_del_responsable_params
	  params.require(:datos_responsable).permit(:responsable_id)
	 end

  def inicializar_variables
    @responsables = Responsable.all
  end
end
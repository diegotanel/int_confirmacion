class PrincipalsController < ApplicationController

	def new
		@provincias = Provincia.all
		@region = Region.all
		@localidades = Localidad.all
		@grupos = Grupo.all
		@registros = Registro.all
  	@principal = Principal.new
  end

  def show
  	@principal = Principal.find(params[:id])
  end

  def create
    @principal = Principal.new(principal_params)
    if @principal.save
    	sign_in @user
    	flash[:success] = "Datos principales correctamente creados"
      redirect_to @formulario
    else
      render 'new'
    end
  end

  def edit
  	@principal = Principal.find(params[:id])
  end

  def update
  	@principal = Principal.find(params[:id])
    if @principal.update_attributes(principal_params)
      flash[:success] = "Datos principales actualizados"
      redirect_to @formulario
    else
      render 'edit'
    end
  end


  private

    def principal_params
      params.require(:formulario).permit(:provincia_id, :localidad_id, :grupo_id, :registro_id, :nombre,
       :condicion_id, :detalle)
    end
end
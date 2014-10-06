class PrincipalsController < ApplicationController
  before_action :inicializar_variables, only: [:new, :edit]


  def new
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

  def obtener_region
    @provincia = Provincia.find(params[:provincia_id])
    @region = @provincia.region
    respond_to do | format |
      #format.json { render json: @listado }
      format.js { render json: @region }
    end
  end

  private

  def principal_params
    params.require(:principal).permit(:provincia_id, :localidad_id, :grupo_id, :registro_id, :nombre,
                                       :condicion_id, :detalle, :condicion_ids => [])
  end

  def inicializar_variables
    @provincias = Provincia.all
    @region = Region.all
    @localidades = Localidad.all
    @grupos = Grupo.all
    @registros = Registro.all
    @condiciones = Condicion.all
  end
end

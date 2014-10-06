class FormulariosController < ApplicationController
	before_action :signed_in_user, only: [:new, :create, :edit, :update]

	def new
  	@formulario = Formulario.new
  end

  def show
    @formulario = Formulario.find(params[:id])
  end

  def index
  	@formularios = current_user.formularios
  end

  def create
    if @formulario = current_user.formularios.create!()
    	flash[:success] = "Formulario correctamente creado"
      redirect_to @formulario
    else
      render 'new'
    end
  end

  def edit
  	@formulario = Formulario.find(params[:id])
  end

  def update
  	@formulario = Formulario.find(params[:id])
    if @formulario.update_attributes(formulario_params)
      flash[:success] = "Formulario actualizado"
      redirect_to @user
    else
      render 'edit'
    end
  end


  private

    def formulario_params
      params.require(:formulario).permit(:principal_id)
    end
end
class FormulariosController < ApplicationController

	def new
  	@formulario = Formulario.new
  end

  def create
    @formulario = Formulario.new(formulario_params)
    if @formulario.save
    	sign_in @user
    	flash[:success] = "Formulario correctamente creado"
      redirect_to @user
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
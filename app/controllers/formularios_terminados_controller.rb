class FormulariosTerminadosController < ApplicationController
  before_action :signed_in_user, only: [:index]

  def index
   @formulario = Formulario.find_by_id(params[:formulario_id])
   @formulario.estado = Formulario::ESTADOS[:enviado]
   @formulario.save!
  end
end

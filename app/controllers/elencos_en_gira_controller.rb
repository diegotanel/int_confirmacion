class ElencosEnGiraController < ApplicationController
  before_action :signed_in_user, only: [:index]

  def index
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @integrantes = []
    @actores = @formulario.elenco_en_gira.integrantes_de_elenco_en_gira.where(type: 'Actor')
    @directores = @formulario.elenco_en_gira.integrantes_de_elenco_en_gira.where(type: 'Director')
    @tecnicos = @formulario.elenco_en_gira.integrantes_de_elenco_en_gira.where(type: 'Tecnico')
    @integrantes = [@actores, @directores, @tecnicos]
  end

  private

  # def principal_params
  #   params.require(:elenco_en_gira).permit(:provincia_id, :localidad_id, :grupo_id, :registro_id, :nombre, :condicion_ids => [])
  # end

end

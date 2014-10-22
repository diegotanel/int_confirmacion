class ElencosEnGiraController < ApplicationController
  before_action :signed_in_user, only: [:index]

  def index
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @integrantes = []
    @formulario.create_elenco_en_gira() unless @formulario.elenco_en_gira
    @actores = @formulario.elenco_en_gira.integrantes_de_elenco_en_gira.where(type: 'Actor')
    @directores = @formulario.elenco_en_gira.integrantes_de_elenco_en_gira.where(type: 'Director')
    @tecnicos = @formulario.elenco_en_gira.integrantes_de_elenco_en_gira.where(type: 'Tecnico')
    @integrantes = [@actores, @directores, @tecnicos]
  end

  def edit
    
  end

  private

end

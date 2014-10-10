#encoding: utf-8
class ElencoEnGira < ActiveRecord::Base

	belongs_to :formulario
	has_many :integrantes_de_elenco_en_gira

	validates :formulario, presence: true

end

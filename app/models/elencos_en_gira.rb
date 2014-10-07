#encoding: utf-8
class ElencosEnGira < ActiveRecord::Base

	belongs_to :formulario
	has_many :actores
	has_many :directores
	has_many :tecnicos

	validates :formulario, presence: true

end

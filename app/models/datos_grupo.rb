class DatosGrupo < ActiveRecord::Base

	attr_accessor :saltear_validaciones_de_presencia
	belongs_to :formulario

	validates :nombre_grupo, presence: true, length: {maximum: 70}
	validates :historia, presence: true, length: {maximum: 700}
	validates :formulario, presence: true
end

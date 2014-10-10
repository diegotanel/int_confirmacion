class DatosGrupo < ActiveRecord::Base

	belongs_to :formulario
	validates :nombre_grupo, presence: true, length: {maximum: 70}
	validates :historia, presence: true, length: {maximum: 200}
	validates :formulario, presence: true
end

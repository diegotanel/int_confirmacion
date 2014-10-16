class DatosEspectaculo < ActiveRecord::Base

	belongs_to :formulario
	has_many :integrantes_del_espectaculo
	has_many :ficha_artisticas
	has_and_belongs_to_many :generos_espectaculos
	has_and_belongs_to_many :publicos_por_experiencia
	has_and_belongs_to_many :publicos_por_edad
	has_and_belongs_to_many :formatos

	validates :formulario, presence: true
	validates :interpretes_escena, presence: true
	validates :directores_espectaculo, presence: true
	validates :fecha_de_estreno, presence: true
	validates :nombre_autor, presence: true
	validates :nacionalidad_autor, presence: true
	validates :duraciom_espectaculo, presence: true
	validates :sinopsis_obra, presence: true
	validates :generos_espectaculos, presence: true
	validates :publicos_por_edad, presence: true
	validates :publicos_por_experiencia, presence: true
	validates :formatos, presence: true
	
end

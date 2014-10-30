class DatosEsp < ActiveRecord::Base

	belongs_to :formulario
	has_many :integrantes_del_esp
	has_many :ficha_artisticas
	has_and_belongs_to_many :gen_esps
	has_and_belongs_to_many :publs_exp
	has_and_belongs_to_many :publs_edad
	has_and_belongs_to_many :formatos

	validates :formulario, presence: true
	validates :fecha_de_estreno, presence: true
	validates :nombre_autor, presence: true, length: {maximum: 100}
	validates :nacionalidad_autor, presence: true, length: {maximum: 50}
	validates :duracion_espectaculo, presence: true, numericality: { only_integer: true }
	validates :sinopsis_obra, presence: true, length: {maximum: 700}
	validates :gen_esps, presence: true
	validates :publs_edad, presence: true
	validates :publs_exp, presence: true
	validates :formatos, presence: true
	
end

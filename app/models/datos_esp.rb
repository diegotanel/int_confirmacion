class DatosEsp < ActiveRecord::Base

	attr_accessor :saltear_validaciones_de_presencia
	belongs_to :formulario
	has_many :integrantes_del_esp
	has_many :ficha_artisticas
	has_and_belongs_to_many :gen_esps
	has_and_belongs_to_many :publs_exp
	has_and_belongs_to_many :publs_edad
	has_and_belongs_to_many :formatos



	validates :formulario, presence: true, unless: :saltear_validaciones_de_presencia
	validates :fecha_de_estreno, presence: true, unless: :saltear_validaciones_de_presencia
	validates :nombre_autor, presence: true, unless: :saltear_validaciones_de_presencia
	validates :nombre_autor, length: {maximum: 100}
	validates :nacionalidad_autor, presence: true, unless: :saltear_validaciones_de_presencia
	validates :nacionalidad_autor, length: {maximum: 50}
	validates :duracion_espectaculo, presence: true, unless: :saltear_validaciones_de_presencia
	validates :duracion_espectaculo, numericality: { only_integer: true }
	validates :sinopsis_obra, presence: true, unless: :saltear_validaciones_de_presencia
	validates :sinopsis_obra, length: {maximum: 700}
	validates :gen_esps, presence: true, unless: :saltear_validaciones_de_presencia
	validates :publs_edad, presence: true, unless: :saltear_validaciones_de_presencia
	validates :publs_exp, presence: true, unless: :saltear_validaciones_de_presencia
	validates :formatos, presence: true, unless: :saltear_validaciones_de_presencia
	
end

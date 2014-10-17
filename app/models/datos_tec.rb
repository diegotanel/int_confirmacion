class DatosTec < ActiveRecord::Base

	belongs_to :formulario
	has_and_belongs_to_many :esps_esps

	validates :formulario, presence: true
	validates :esps_esps, presence: true
	validates :duracion_montaje, presence: true, numericality: { only_integer: true }
  validates :duracion_desmontaje, presence: true, numericality: { only_integer: true }
  validates :ancho, presence: true
  validates :alto, presence: true
  validates :profundidad, presence: true
  validates :listado_artefactos_luminicos, presence: true, length: {maximum: 500}
  validates :listado_sonido, presence: true, length: {maximum: 500}
  validates :otros_equipamientos, length: {maximum: 500}
  validates :peso_total, presence: true
  validates :volumen_total, presence: true
  validates :otras_necesidades, length: {maximum: 500}
  validates :descripcion_espacio, presence: true, length: {maximum: 500}

end

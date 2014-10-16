class FichaArtistica < ActiveRecord::Base

	belongs_to :datos_espectaculo

	validates :datos_espectaculo, presence: true
	validates :nombre_artista, presence: true
	validates :apellido_artista, presence: true
	validates :rol_artista, presence: true
end

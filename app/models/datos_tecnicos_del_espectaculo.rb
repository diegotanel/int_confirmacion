class DatosTecnicosDelEspectaculo < ActiveRecord::Base

	belongs_to :formulario
	has_many :espacios_espectaculos

	validates :formulario, presence: true
end

class IntegranteDelEspectaculo < ActiveRecord::Base

	belongs_to :datos_espectaculo

	validates :datos_espectaculo, presence: true
end

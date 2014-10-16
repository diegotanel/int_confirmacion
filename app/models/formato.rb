class Formato < ActiveRecord::Base

	has_and_belongs_to_many :datos_espectaculos

	validates :datos_espectaculos, presence: true
	validates :detalle, presence: true
end

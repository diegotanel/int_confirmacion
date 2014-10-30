class Responsable < ActiveRecord::Base

	belongs_to :formulario
	has_one :persona_juridica
	has_one :persona_fisica_n
	has_one :persona_fisica_e

	validates :detalle, presence: true
	validates :formulario, presence: true
end

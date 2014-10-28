class Responsable < ActiveRecord::Base

	belongs_to :datos_del_responsable
	has_one :persona_juridica
	has_one :persona_fisica_n
	has_one :persona_fisica_e

	validates :detalle, presence: true
end

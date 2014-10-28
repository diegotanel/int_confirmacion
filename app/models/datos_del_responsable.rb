class DatosDelResponsable < ActiveRecord::Base

	belongs_to :formulario
	has_one :responsable

	validates :formulario, presence: true
	validates :responsable, presence: true
end

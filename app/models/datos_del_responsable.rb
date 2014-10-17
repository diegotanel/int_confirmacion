class DatosDelResponsable < ActiveRecord::Base

	belongs_to :formulario
	belongs_to :responsable

	validates :formulario, presence: true
	validates :responsable, presence: true
end

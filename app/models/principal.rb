class Principal < ActiveRecord::Base
	belongs_to :provincia
	belongs_to :grupo
	belongs_to :localidad
	belongs_to :condicion
	belongs_to :registro
	belongs_to :formulario

	validates :provincia, presence: true
	validates :grupo, presence: true
	validates :localidad, presence: true
	validates :condicion, presence: true
	validates :detalle, presence: true, length: {maximum: 70}
	validates :nombre, presence: true, length: {maximum: 70}
	validates :registro, presence: true
	validates :formulario, presence: true
end

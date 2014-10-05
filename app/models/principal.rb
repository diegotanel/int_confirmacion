class Principal < ActiveRecord::Base
	has_and_belongs_to_many :condiciones
	belongs_to :provincia
	belongs_to :grupo
	belongs_to :localidad
	belongs_to :registro
	belongs_to :formulario

	validates :provincia, presence: true
	validates :grupo, presence: true
	validates :localidad, presence: true
	validates :condiciones, presence: true
	validates :detalle, presence: true, length: {maximum: 70}
	validates :nombre, presence: true, length: {maximum: 70}
	validates :registro, presence: true
	validates :formulario, presence: true
end

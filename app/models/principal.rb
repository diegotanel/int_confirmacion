class Principal < ActiveRecord::Base
	belongs_to :provincia
	belongs_to :grupo
	belongs_to :localidad
	belongs_to :condicion

	attr_accessible :provincia_id, :grupo_id, :localidad_id, :condicion_id, :detalle

	validates :provincia, presence: true
	validates :grupo, presence: true
	validates :localidad, presence: true
	validates :condicion, presence: true
	validates :detalle, presence: true
	validates :nombre, presence: true
end

class Principal < ActiveRecord::Base
	belongs_to :grupo
	belongs_to :localidad
	belongs_to :formulario

  delegate :provincia, to: :localidad
  delegate :provincia_id, to: :localidad

	validates :grupo, presence: true
	validates :localidad, presence: true
	validates :nombre, presence: true, length: {maximum: 70}
	validates :formulario, presence: true
end

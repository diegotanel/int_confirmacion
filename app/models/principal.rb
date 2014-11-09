class Principal < ActiveRecord::Base
  belongs_to :grupo
  belongs_to :localidad
  belongs_to :formulario

  delegate :provincia, to: :localidad
  delegate :provincia_id, to: :localidad
  delegate :region, to: 'localidad.provincia'
  delegate :region_id, to: 'localidad.provincia'

  validates :grupo, presence: true
  validates :localidad, presence: true
  validates :nombre, presence: true, length: {maximum: 70}
  validates :formulario, presence: true
end

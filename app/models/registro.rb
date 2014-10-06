class Registro < ActiveRecord::Base
	has_one :principal

  validates :numero_de_registro, presence: true, length: {maximum: 10, minimum: 10}
	validates :detalle, presence: true
end

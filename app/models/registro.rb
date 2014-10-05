class Registro < ActiveRecord::Base
	has_one :principal

  validates :numero, presence: true, length: {maximum: 10}
	validates :detalle, presence: true
end

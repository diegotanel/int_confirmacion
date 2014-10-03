class Registro < ActiveRecord::Base
	has_one :principal

	validates :detalle, presence: true, length: {maximum: 10}
end

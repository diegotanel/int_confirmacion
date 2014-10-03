class Localidad < ActiveRecord::Base
	has_one :principal

	validates :detalle, presence: true, length: {maximum: 70}
end

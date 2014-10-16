class Localidad < ActiveRecord::Base
	has_one :principal
	belongs_to :provincia

	validates :detalle, presence: true, length: {maximum: 70}
	validates :provincia, presence: true
end

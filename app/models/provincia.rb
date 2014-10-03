class Provincia < ActiveRecord::Base
	has_one :principal
	belongs_to :region

	validates :detalle, presence: true, length: {maximum: 70}
	validates :region, presence: true
end

class Condicion < ActiveRecord::Base
	has_one :principal
	attr_accessible :detalle


	validates :detalle, presence: true
end

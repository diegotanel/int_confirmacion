class Provincia < ActiveRecord::Base
	belongs_to :principal
	belongs_to :region
	attr_accessible :detalle

	validates :detalle, :presence => true
end

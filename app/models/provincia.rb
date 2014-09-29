class Provincia < ActiveRecord::Base
	belongs_to :principal
	has_many :regiones
	attr_accessible :detalle

	validates :detalle, :presence => true
end

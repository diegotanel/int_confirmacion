class Region < ActiveRecord::Base
	has_many :provincias
	attr_accessible :detalle


	validates :detalle, :presence => true
end

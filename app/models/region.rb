class Region < ActiveRecord::Base
	belongs_to :provincia
	attr_accessible :detalle


	validates :detalle, :presence => true
end

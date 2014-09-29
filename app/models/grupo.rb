class Grupo < ActiveRecord::Base
	belongs_to :principal
	attr_accessible :detalle


	validates :detalle, :presence => true
end

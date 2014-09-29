class Provincia < ActiveRecord::Base
	belongs_to :principal
	has_many :regiones
end

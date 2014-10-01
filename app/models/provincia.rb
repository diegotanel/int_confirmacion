class Provincia < ActiveRecord::Base
	has_one :principal
	belongs_to :region
	attr_accessible :detalle, :region_id

	validates :detalle, presence: true
	validates :region, presence: true
end

class Region < ActiveRecord::Base
	has_many :provincias

	validates :detalle, presence: true, length: {maximum: 70}
end

class Grupo < ActiveRecord::Base
	has_one :principal

	validates :detalle, presence: true
end

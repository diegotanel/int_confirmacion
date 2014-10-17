class Responsable < ActiveRecord::Base

	has_one :datos_del_responsable

	validates :detalle, presence: true
end

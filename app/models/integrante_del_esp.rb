class IntegranteDelEsp < ActiveRecord::Base

	belongs_to :datos_esp

	validates :datos_esp, presence: true
end

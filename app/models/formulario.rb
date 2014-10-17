class Formulario < ActiveRecord::Base
	belongs_to :user
	has_one :principal
	has_one :elenco_en_gira
	has_one :datos_grupo
	has_one :datos_esp
	has_one :datos_tec
	has_one :datos_del_responsable

	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
	validates :estado, presence: true

	ESTADOS = {:final => 1, :borrador => 2 }

	private
		after_initialize do
			self.estado ||= Formulario::ESTADOS[:borrador]
		end
end

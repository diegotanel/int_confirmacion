class Formulario < ActiveRecord::Base
	belongs_to :user
	has_one :principal

	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
	validates :estado, presence: true

	ESTADOS = {:final => 1, :borrador => 2 }

	private
		after_initialize do
			self.estado ||= Formulario::ESTADOS[:borrador]
		end
end

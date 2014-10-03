class Formulario < ActiveRecord::Base
	belongs_to :user
	has_one :principal

	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
end

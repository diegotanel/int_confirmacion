#encoding: utf-8
class Tecnico < ActiveRecord::Base
	belongs_to :elencos_en_gira

	before_save { self.email = email.downcase }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i

	validates :nombre_tecnico, presence: true, length: {maximum: 70}
    validates :apellido_tecnico, presence: true, length: {maximum: 70}
    validates :num_de_cuil_cuit, presence: true, length: {maximum: 11, minimum: 11}, numericality: { only_integer: true }
    validates :fecha_de_nacimiento, presence: true
    validates :calle, presence: true
    validates :altura_calle, presence: true, numericality: { only_integer: true }
    validates :tecnico_provincia, presence: true
    validates :tecnico_localidad, presence: true
    validates :codigo_postal, presence: true
    validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, 
	uniqueness: { case_sensitive: false }
	validates :elencos_en_gira, presence: true
end

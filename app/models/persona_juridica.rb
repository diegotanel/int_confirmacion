class PersonaJuridica < ActiveRecord::Base

	belongs_to :localidad
  belongs_to :responsable
  has_many :integrantes_comision_directiva

  before_save { self.email_entidad = email_entidad.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i

  delegate :provincia, to: :localidad
  delegate :provincia_id, to: :localidad

  validates :nombre_per_juridica, presence: true, length: {maximum: 70}
  validates :num_cuit_per_juridica, presence: true, length: {maximum: 11, minimum: 11}, numericality: { only_integer: true }, uniqueness: { case_sensitive: false }
  validates :num_per_juridica, presence: true, numericality: { only_integer: true }
  validates :calle, presence: true
  validates :altura_calle, presence: true, numericality: { only_integer: true }
  validates :localidad, presence: true
  validates :codigo_postal, presence: true
  validates :email_entidad, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }
  validates :datos_del_responsable, presence: true
  validates :tel_entidad, numericality: { only_integer: true }, allow_blank: true
end

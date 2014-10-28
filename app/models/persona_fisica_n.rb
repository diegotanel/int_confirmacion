class PersonaFisicaN < ActiveRecord::Base

	belongs_to :localidad
  belongs_to :responsable

  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i

  delegate :provincia, to: :localidad
  delegate :provincia_id, to: :localidad

  validates :nombre_per_fisica, presence: true, length: {maximum: 70}
  validates :apellido_per_fisica, presence: true, length: {maximum: 70}
  validates :cuil_cuit_per_fisica, presence: true, length: {maximum: 11, minimum: 11}, numericality: { only_integer: true }
  validates :fecha_de_nacimiento, presence: true
  validates :calle, presence: true
  validates :altura_calle, presence: true, numericality: { only_integer: true }
  validates :localidad, presence: true
  validates :codigo_postal, presence: true
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }
  validates :datos_del_responsable, presence: true
  validates :tel_particular, numericality: { only_integer: true }, allow_blank: true
  validates :tel_celular, presence: true, numericality: { only_integer: true }
end

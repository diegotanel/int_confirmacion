class IntegrantePersonaJuridica < ActiveRecord::Base

	belongs_to :localidad
  belongs_to :persona_juridica

  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i

  delegate :provincia, to: :localidad
  delegate :provincia_id, to: :localidad

  validates :nombre, presence: true, length: {maximum: 70}
  validates :apellido, presence: true, length: {maximum: 70}
  validates :cargo, presence: true
  validates :cuil_cuit, presence: true, length: {maximum: 11, minimum: 11}, numericality: { only_integer: true }
  validates :fecha_de_nacimiento, presence: true
  validates :calle, presence: true
  validates :altura_calle, presence: true, numericality: { only_integer: true }
  validates :localidad, presence: true
  validates :codigo_postal, presence: true
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }
  validates :persona_juridica, presence: true
  validates :tel_particular, numericality: { only_integer: true }, allow_blank: true
  validates :tel_celular, numericality: { only_integer: true }, allow_blank: true
end
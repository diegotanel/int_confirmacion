class PersonaFisicaN < ActiveRecord::Base
  
  attr_accessor :saltear_validaciones_de_presencia
	belongs_to :localidad
  belongs_to :responsable

  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i

  delegate :provincia, to: :localidad
  delegate :provincia_id, to: :localidad

  validates :nombre, presence: true, unless: :saltear_validaciones_de_presencia
  validates :nombre, length: {maximum: 70}
  validates :apellido, presence: true, unless: :saltear_validaciones_de_presencia
  validates :apellido, length: {maximum: 70}
  validates :cuil_cuit, presence: true, unless: :saltear_validaciones_de_presencia
  validates :cuil_cuit, length: {maximum: 11, minimum: 11}, numericality: { only_integer: true }
  validates :fecha_de_nacimiento, presence: true, unless: :saltear_validaciones_de_presencia
  validates :calle, presence: true, unless: :saltear_validaciones_de_presencia
  validates :altura_calle, presence: true, unless: :saltear_validaciones_de_presencia
  validates :altura_calle, numericality: { only_integer: true }
  validates :localidad, presence: true, unless: :saltear_validaciones_de_presencia
  validates :codigo_postal, presence: true, unless: :saltear_validaciones_de_presencia
  validates :email, presence: true, unless: :saltear_validaciones_de_presencia
  validates :email, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }
  validates :responsable, presence: true
  validates :tel_particular, numericality: { only_integer: true }, allow_blank: true
  validates :tel_celular, presence: true, unless: :saltear_validaciones_de_presencia
  validates :tel_celular, numericality: { only_integer: true }
end

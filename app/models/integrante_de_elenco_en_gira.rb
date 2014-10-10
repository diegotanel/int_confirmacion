class IntegranteDeElencoEnGira < ActiveRecord::Base
  belongs_to :provincia
  belongs_to :localidad
  belongs_to :elenco_en_gira

  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :nombre, presence: true, length: {maximum: 70}
  validates :apellido, presence: true, length: {maximum: 70}
  validates :cuil_cuit, presence: true, length: {maximum: 11, minimum: 11}, numericality: { only_integer: true }
  validates :fecha_de_nacimiento, presence: true
  validates :calle, presence: true
  validates :altura_calle, presence: true, numericality: { only_integer: true }
  validates :provincia, presence: true
  validates :localidad, presence: true
  validates :codigo_postal, presence: true
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }
  validates :elenco_en_gira, presence: true


end

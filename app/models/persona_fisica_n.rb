class PersonaFisicaN < ActiveRecord::Base
  before_save :validacion_digitoverificador_de_cuit_cuil
  
  belongs_to :localidad
  belongs_to :responsable

  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i

  delegate :provincia, to: :localidad
  delegate :provincia_id, to: :localidad

  validate :validacion_tel_particular_tel_celular

  validates :nombre, presence: true, length: {maximum: 70}
  validates :apellido, presence: true, length: {maximum: 70}
  validates :cuil_cuit, presence: true, length: {maximum: 11, minimum: 11}, numericality: { only_integer: true }
  validates :fecha_de_nacimiento, presence: true
  validates :calle, presence: true
  validates :altura_calle, presence: true, numericality: { only_integer: true }
  validates :localidad, presence: true
  validates :codigo_postal, presence: true
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }
  validates :responsable, presence: true
  validates :tel_particular, numericality: { only_integer: true }, allow_blank: true
  validates :tel_celular, presence: true, numericality: { only_integer: true }

  def validacion_digitoverificador_de_cuit_cuil
    @validador = ValidadorCuitCuil.new
    if cuil_cuit.presence
      errors[:cuil_cuit] << "debe estar formado correctamente" unless @validador.validardigitoverificador(self.cuil_cuit)
    end
  end

  def validacion_tel_particular_tel_celular
    @es_valido = nil
    tel_particular.blank? ? @es_valido = false : @es_valido = true

    unless @es_valido
      if tel_celular.blank?
        errors[:base] << "Debe completarse el teléfono particular o el teléfono celular"
      end
    end
  end

end

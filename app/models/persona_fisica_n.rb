class PersonaFisicaN < ActiveRecord::Base

  attr_accessor :saltear_validaciones_de_presencia
  before_save :validacion_digitoverificador_de_cuit_cuil, :validacion_tel_particular_tel_celular
  
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
  validates :altura_calle, numericality: { only_integer: true }, allow_blank: true
  validates :localidad, presence: true, unless: :saltear_validaciones_de_presencia
  validates :codigo_postal, presence: true, unless: :saltear_validaciones_de_presencia
  validates :email, presence: true, unless: :saltear_validaciones_de_presencia
  validates :email, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }
  validates :responsable, presence: true
  validates :tel_particular, numericality: { only_integer: true }, allow_blank: true
  validates :tel_celular, numericality: { only_integer: true }, allow_blank: true

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

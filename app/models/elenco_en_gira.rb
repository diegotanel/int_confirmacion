#encoding: utf-8
class ElencoEnGira < ActiveRecord::Base

  attr_accessor :saltear_validaciones_de_presencia
  belongs_to :formulario
  has_many :integrantes_de_elenco_en_gira

  validates :formulario, presence: true
  validates_associated :integrantes_de_elenco_en_gira
  validate :validacion_minimo_un_interprete, unless: :saltear_validaciones_de_presencia 
  validate :validacion_maximo_tres_directores, :validacion_maximo_dos_tecnicos, :validacion_combinacion_director_tecnico
  

  def validacion_minimo_un_interprete
    errors[:base] << "Como mínimo se debe adicionar un intérprete en elenco en gira" unless minimo_un_interprete
  end

  def minimo_un_interprete
    self.integrantes_de_elenco_en_gira.find_by_type("Actor")
  end

  def validacion_maximo_tres_directores
    errors[:base] << "No puede haber más de tres directores" unless self.maximo_tres_directores
  end

  def maximo_tres_directores
    self.integrantes_de_elenco_en_gira.where(type: "Director").count < 4
  end

  def validacion_maximo_dos_tecnicos
    errors[:base] << "No puede haber más de dos técnicos" unless self.maximo_dos_tecnicos
  end

  def maximo_dos_tecnicos
    self.integrantes_de_elenco_en_gira.where(type: "Tecnico").count < 3
  end

  def validacion_combinacion_director_tecnico
    errors[:base] << "Como máximo la cantidad de tres, entre directores y técnicos" unless self.combinacion_director_tecnico
  end

  def combinacion_director_tecnico
    directores = self.integrantes_de_elenco_en_gira.where(type: "Director").count
    tecnicos = self.integrantes_de_elenco_en_gira.where(type: "Tecnico").count
    directores + tecnicos > 3 ? false : true
  end
end

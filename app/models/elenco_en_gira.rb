#encoding: utf-8
class ElencoEnGira < ActiveRecord::Base

  belongs_to :formulario
  has_many :integrantes_de_elenco_en_gira

  validates :formulario, presence: true

  validates :integrantes_de_elenco_en_gira, presence: true, if: :es_interprete?

  def es_interprete?
    result = nil
    self.integrantes_de_elenco_en_gira.each { |i|
      if i.type == "Actor"
        result = true
      end
      break
    }
    result
  end
end

class PersonaFisicaE < ActiveRecord::Base
  belongs_to :responsable
  belongs_to :integrante_de_elenco_en_gira

  validates :responsable, presence: true
  validates :integrante_de_elenco_en_gira, presence: true

end

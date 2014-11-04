class CambioDeLongDeSinopsisDeLaObra < ActiveRecord::Migration
  def up
    change_table :datos_esps do |t|
      t.change :sinopsis_obra, :text
    end
  end

  def down
    change_table :datos_esps do |t|
      t.change :sinopsis_obra, :string
    end
  end
end

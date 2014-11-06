class CambioDeLongDeCamposDeTextoDatosGrupos < ActiveRecord::Migration
  def up
    change_table :datos_grupos do |t|
      t.change :nombre_grupo, :text
      t.change :historia, :text
    end
  end

  def down
    change_table :datos_grupos do |t|
      t.change :nombre_grupo, :string
      t.change :historia, :string
    end
  end
end

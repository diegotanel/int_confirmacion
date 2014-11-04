class CambioDeLongDeCamposDeTextoDatosTecs < ActiveRecord::Migration
  def up
    change_table :datos_tecs do |t|
      t.change :descripcion_espacio, :text
      t.change :listado_artefactos_luminicos, :text
      t.change :listado_sonido, :text
      t.change :otros_equipamientos, :text
      t.change :otras_necesidades, :text
      t.change :imagen_file_name, :text
      t.change :imagen_content_type, :text
    end
  end

  def down
    change_table :datos_tecs do |t|
      t.change :descripcion_espacio, :string
      t.change :listado_artefactos_luminicos, :string
      t.change :listado_sonido, :string
      t.change :otros_equipamientos, :string
      t.change :otras_necesidades, :string
      t.change :imagen_file_name, :string
      t.change :imagen_content_type, :string
    end
  end
end

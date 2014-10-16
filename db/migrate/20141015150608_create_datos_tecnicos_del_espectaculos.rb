class CreateDatosTecnicosDelEspectaculos < ActiveRecord::Migration
  def change
    create_table :datos_tecnicos_del_espectaculos do |t|

    	t.string :duracion_montaje, :null => false
    	t.string :duracion_desmontaje, :null => false
    	t.string :ancho, :null => false
    	t.string :alto, :null => false
    	t.string :profundidad, :null => false
    	t.string :listado_artefactos_luminicos, :null => false
    	t.string :listado_sonido, :null => false
    	t.string :otros_equipamientos, :null => false
    	t.string :peso_total, :null => false
    	t.string :volumen_total, :null => false
    	t.string :otras_necesidades, :null => false


      t.timestamps
    end
  end
end

class CreateDatosEsps < ActiveRecord::Migration
  def change
    create_table :datos_esps do |t|
    	t.references :formulario, :null => false
    	t.date :fecha_de_estreno, :null => false
    	t.string :nombre_autor, :null => false
    	t.string :nacionalidad_autor, :null => false
    	t.string :duracion_espectaculo, :null => false
    	t.string :interpretes_escena, :null => false
    	t.string :directores_espectaculo, :null => false
    	t.string :sinopsis_obra, :null => false
    	t.string :pagina_web
    	t.string :facebook
    	t.string :twitter
    	t.string :foro
    	t.string :blog
    	t.string :youtube
    	t.string :instagram


      t.timestamps
    end
    add_index :datos_esps, :formulario_id
  end
end

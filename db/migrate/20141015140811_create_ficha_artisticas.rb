class CreateFichaArtisticas < ActiveRecord::Migration
  def change
    create_table :ficha_artisticas do |t|
    	t.string :nombre_artista, :null => false
    	t.string :apellido_artista, :null => false
    	t.string :rol_artista, :null => false

      t.timestamps
    end
  end
end

class CreateEspaciosEspectaculos < ActiveRecord::Migration
  def change
    create_table :espacios_espectaculos do |t|

    	t.string :detalle, :null => false
    	t.string :descripcion, :null => false

      t.timestamps
    end
  end
end

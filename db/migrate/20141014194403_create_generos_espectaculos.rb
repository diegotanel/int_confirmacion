class CreateGenerosEspectaculos < ActiveRecord::Migration
  def change
    create_table :generos_espectaculos do |t|
    	t.string :detalle, :null => false

      t.timestamps
    end
  end
end

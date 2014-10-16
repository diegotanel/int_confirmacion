class CreateTecnicosDelEspectaculo < ActiveRecord::Migration
  def change
    create_table :tecnicos_del_espectaculo do |t|
    	t.string :detalle, :null => false

      t.timestamps
    end
  end
end

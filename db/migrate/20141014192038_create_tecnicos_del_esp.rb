class CreateTecnicosDelEsp < ActiveRecord::Migration
  def change
    create_table :tecnicos_del_esp do |t|
    	t.string :detalle, :null => false

      t.timestamps
    end
  end
end

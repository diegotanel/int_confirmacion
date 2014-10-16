class CreateEspsEsps < ActiveRecord::Migration
  def change
    create_table :esps_esps do |t|

    	t.string :detalle, :null => false
    	t.string :descripcion, :null => false

      t.timestamps
    end
  end
end

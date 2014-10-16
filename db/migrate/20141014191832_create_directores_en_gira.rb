class CreateDirectoresEnGira < ActiveRecord::Migration
  def change
    create_table :directores_en_gira do |t|
    	t.string :detalle, :null => false

      t.timestamps
    end
  end
end

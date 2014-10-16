class CreatePublicosPorEdad < ActiveRecord::Migration
  def change
    create_table :publicos_por_edad do |t|
    	t.string :detalle, :null => false

      t.timestamps
    end
  end
end

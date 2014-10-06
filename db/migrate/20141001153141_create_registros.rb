class CreateRegistros < ActiveRecord::Migration
  def change
    create_table :registros do |t|
      t.string :numero_de_registro, :null => false
      t.string :detalle, :null => false

      t.timestamps
    end
  end
end

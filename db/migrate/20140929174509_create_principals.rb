class CreatePrincipals < ActiveRecord::Migration
  def change
    create_table :principals do |t|
      t.references :provincia
      t.references :localidad
      t.references :grupo
      t.references :condicion
      t.string :nombre
      t.string :detalle
      t.references :registro

      t.timestamps
    end
    add_index :principals, :provincia_id
    add_index :principals, :localidad_id
    add_index :principals, :grupo_id
    add_index :principals, :condicion_id
    add_index :principals, :registro_id
  end
end

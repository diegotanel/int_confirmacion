class CreatePrincipals < ActiveRecord::Migration
  def change
    create_table :principals do |t|
      t.references :provincia
      t.references :localidad
      t.references :grupo
      t.references :nombre
      t.references :condicion

      t.timestamps
    end
    add_index :principals, :provincia_id
    add_index :principals, :localidad_id
    add_index :principals, :grupo_id
    add_index :principals, :nombre_id
    add_index :principals, :condicion_id
  end
end

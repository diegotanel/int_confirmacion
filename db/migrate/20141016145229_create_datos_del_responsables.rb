class CreateDatosDelResponsables < ActiveRecord::Migration
  def change
    create_table :datos_del_responsables do |t|

    	t.references :formulario, :null => false
    	t.references :responsable, :null => false

      t.timestamps
    end
    add_index :datos_del_responsables, :formulario_id
    add_index :datos_del_responsables, :responsable_id
  end
end

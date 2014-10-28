class CreateResponsables < ActiveRecord::Migration
  def change
    create_table :responsables do |t|
    	t.string :type, :null => false
    	t.string :detalle, :null => false
    	t.references :datos_del_responsable, index: true, :null => false

      t.timestamps
    end
    add_index :responsables, :type
  end
end

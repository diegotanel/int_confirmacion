class CreateResponsables < ActiveRecord::Migration
  def change
    create_table :responsables do |t|
    	t.string :detalle, :null => false
    	t.references :formulario, index: true, :null => false

      t.timestamps
    end
  end
end

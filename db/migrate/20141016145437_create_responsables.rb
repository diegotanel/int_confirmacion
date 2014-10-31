class CreateResponsables < ActiveRecord::Migration
  def change
    create_table :responsables do |t|
    	t.references :formulario, index: true, :null => false

      t.timestamps
    end
  end
end

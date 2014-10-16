class CreateIntegrantesDelEsp < ActiveRecord::Migration
  def change
    create_table :integrantes_del_esp do |t|
    	t.string :rol, :null => false
    	t.string :nombre_integrante, :null => false
    	t.string :apellido_integrante, :null => false

      t.timestamps
    end
  end
end

class CreatePersonasJuridicas < ActiveRecord::Migration
  def change
    create_table :personas_juridicas do |t|
    	
    	t.string :nombre_per_juridica, :null => false
    	t.string :num_cuit, :null => false, unique: true
    	t.string :num_per_juridica, :null => false
      t.string :calle, :null => false
      t.string :altura_calle, :null => false
      t.string :piso
      t.string :depto
      t.references :localidad, index: true, :null => false
      t.string :codigo_postal, :null => false
      t.string :tel_entidad
      t.string :email_entidad, :null => false, unique: true
      t.references :responsable, index: true, :null => false

      t.timestamps
    end
  end
end

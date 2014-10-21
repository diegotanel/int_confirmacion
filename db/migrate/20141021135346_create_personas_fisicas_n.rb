class CreatePersonasFisicasN < ActiveRecord::Migration
  def change
    create_table :personas_fisicas_n do |t|

    	t.string :nombre_per_fisica, :null => false
      t.string :apellido_per_fisica, :null => false
      t.string :cuil_cuit_per_fisica, :null => false
      t.datetime :fecha_de_nacimiento, :null => false
      t.string :calle, :null => false
      t.string :altura_calle, :null => false
      t.string :piso
      t.string :depto
      t.references :localidad, index: true, :null => false
      t.string :codigo_postal, :null => false
      t.string :tel_particular
      t.string :tel_celular, :null => false
      t.string :email, :null => false
      t.references :datos_del_responsable, index: true, :null => false

      t.timestamps
    end
  end
end

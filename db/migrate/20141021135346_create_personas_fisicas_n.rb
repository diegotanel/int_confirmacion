class CreatePersonasFisicasN < ActiveRecord::Migration
  def change
    create_table :personas_fisicas_n do |t|

      t.references :responsable, index: true, :null => false
      t.string :nombre, :null => false
      t.string :apellido, :null => false
      t.string :cuil_cuit, :null => false, unique: true
      t.datetime :fecha_de_nacimiento, :null => false
      t.string :calle, :null => false
      t.string :altura_calle, :null => false
      t.string :piso
      t.string :depto
      t.references :localidad, index: true, :null => false
      t.string :codigo_postal, :null => false
      t.string :tel_particular
      t.string :tel_celular
      t.string :email, :null => false, unique: true
      t.timestamps

      t.timestamps
    end
  end
end

class CreateDirectores < ActiveRecord::Migration
  def change
    create_table :directores do |t|
      t.string :nombre_director, :null => false
      t.string :apellido_director, :null => false
      t.string :num_de_cuil_cuit, :null => false
      t.date :fecha_de_nacimiento, :null=> false
      t.string :calle, :null=> false
      t.string :altura_calle, :null=> false
      t.string :piso
      t.string :depto
      t.string :director_localidad, :null=> false
      t.string :director_provincia, :null=> false
      t.string :codigo_postal, :null=> false
      t.string :tel_particular
      t.string :tel_celular
      t.string :email, :null => false
      t.references :elencos_en_gira, :null => false

      t.timestamps
    end
    add_index :directores, :elencos_en_gira_id
  end
end

class CreateElencosEnGiras < ActiveRecord::Migration
  def change
    create_table :elencos_en_giras do |t|
    	t.references :formulario, :null => false

      t.timestamps
    end
    add_index :elencos_en_giras, :formulario_id
  end
end

class CreatePublicosPorExperiencia < ActiveRecord::Migration
  def change
    create_table :publicos_por_experiencia do |t|
    	t.string :detalle, :null => false

      t.timestamps
    end
  end
end

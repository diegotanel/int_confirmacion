class CreateRegistros < ActiveRecord::Migration
  def change
    create_table :registros do |t|
      t.string :detalle

      t.timestamps
    end
  end
end

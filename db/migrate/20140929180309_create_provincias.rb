class CreateProvincias < ActiveRecord::Migration
  def change
    create_table :provincias do |t|
      t.string :detalle

      t.timestamps
    end
  end
end

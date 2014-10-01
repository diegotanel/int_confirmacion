class CreateProvincias < ActiveRecord::Migration
  def change
    create_table :provincias do |t|
      t.string :detalle
      t.references :region
      t.timestamps
    end
    add_index :provincias, :region_id
  end
end

class CreateNombres < ActiveRecord::Migration
  def change
    create_table :nombres do |t|
      t.string :detalle

      t.timestamps
    end
  end
end

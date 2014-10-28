class CreatePersonasFisicasN < ActiveRecord::Migration
  def change
    create_table :personas_fisicas_n do |t|

      t.references :persona, index: true, :null => false
      t.references :responsable, index: true, :null => false

      t.timestamps
    end
  end
end

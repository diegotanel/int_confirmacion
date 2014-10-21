class CreatePersonasFisicasE < ActiveRecord::Migration
  def change
    create_table :personas_fisicas_e do |t|

      t.timestamps
    end
  end
end

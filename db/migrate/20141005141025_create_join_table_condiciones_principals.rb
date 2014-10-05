class CreateJoinTableCondicionesPrincipals < ActiveRecord::Migration
  def change
    create_join_table :condiciones, :principals do |t|
      t.belongs_to :condicion, :null => false
      t.belongs_to :principal, :null => false

      t.index [:condicion_id, :principal_id]
      # t.index [:principal_id, :condicion_id]
    end
  end
end

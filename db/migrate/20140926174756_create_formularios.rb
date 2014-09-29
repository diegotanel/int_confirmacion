class CreateFormularios < ActiveRecord::Migration
	def change
    create_table :formularios do |t|
    	t.references :principal
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    add_index :formularios, [:user_id, :created_at]
    add_index :formularios, :principal_id
  end
end

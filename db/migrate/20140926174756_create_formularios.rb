class CreateFormularios < ActiveRecord::Migration
	def change
    create_table :formularios do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    add_index :formularios, [:user_id, :created_at]
  end
end

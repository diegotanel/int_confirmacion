class CambioDeLongDeSitiosWeb < ActiveRecord::Migration
  def up
    change_table :datos_esps do |t|
      t.change :pagina_web, :text
      t.change :facebook, :text
      t.change :twitter, :text
      t.change :blog, :text
      t.change :youtube, :text
      t.change :instagram, :text
    end
  end

  def down
    change_table :datos_esps do |t|
      t.change :pagina_web, :string
      t.change :facebook, :string
      t.change :twitter, :string
      t.change :blog, :string
      t.change :youtube, :string
      t.change :instagram, :string
    end
  end
end
